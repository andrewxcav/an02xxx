#include <print.h>
#include <xs1.h> // xcore primitives

#include "platform.h" // header generated from .xn file

#include "i2c.h"
#include "uart.h"

// I2C interface ports
on tile[0]:port p_scl = XS1_PORT_1E;
on tile[0]:port p_sda = XS1_PORT_1F;
#define I2C_ADDR (0x18)

// UART interface declarations
on tile[0]:port p_uart_rx = on tile[0] : XS1_PORT_1J;
on tile[0]:port p_uart_tx = on tile[0] : XS1_PORT_1M;

#define BAUD_RATE 115200
#define RX_BUFFER_SIZE 64


/* This function performs the main "application" bridges UART to I2C, note this would not need to be
modified if these peripherals were on different tiles */
void app(client uart_tx_if uart_tx, client uart_rx_if uart_rx, client interface i2c_master_if i2c)
{
  uint8_t byte;
  printstrln("I2C to UART converter");
  byte = 0;
  i2c_regop_res_t res;
  for (size_t i = 0; i < 20; i++) {

      if(uart_rx.wait_for_data_and_read() == I2C_ADDR)
      {
        // get address and do a read over I2C
        uint8_t reg = uart_rx.wait_for_data_and_read(); // register
        byte = i2c.read_reg(I2C_ADDR, reg, res);
        if(res==I2C_REGOP_SUCCESS) uart_tx.write(byte);  // send read byte over UART
      }
      else if(uart_rx.wait_for_data_and_read() == (I2C_ADDR|1)){
        // get address and do a write over I2C
        uint8_t reg = uart_rx.wait_for_data_and_read(); // register
        byte = uart_rx.wait_for_data_and_read(); // data
        if(i2c.write_reg(I2C_ADDR, reg, byte) == I2C_REGOP_SUCCESS) uart_tx.write(0x01);  // send ack (optional)
      }
      else{
        //send error code
        uart_tx.write(0xBA);
        uart_tx.write(0xDF);
        uart_tx.write(0x00);
        uart_tx.write(0xD0);
      }
  }
  printstrln(". Done.");
}

int main()
{
  // i2c library declaration
  i2c_master_if i_i2c[1];
  
  // UART library declarations
  interface uart_rx_if i_rx;
  interface uart_tx_if i_tx;
  input_gpio_if i_gpio_rx;
  output_gpio_if i_gpio_tx[1];

  par {
    on tile[0]: output_gpio(i_gpio_tx, 1, p_uart_tx, null); // uart gpio abstraction
    on tile[0]: uart_tx(i_tx, null,
                        BAUD_RATE, UART_PARITY_NONE, 8, 1,
                        i_gpio_tx[0]); // spin up a UART tx task
    on tile[0].core[0] : input_gpio_1bit_with_events(i_gpio_rx, p_uart_rx); // uart gpio abstraction
    on tile[0].core[0] : uart_rx(i_rx, null, RX_BUFFER_SIZE,
                                 BAUD_RATE, UART_PARITY_NONE, 8, 1,
                                 i_gpio_rx); // spin up a UART rx task
    on tile[0]: i2c_master(i_i2c, 1, p_scl, p_sda, 10); // spin up a task for the I2C peripheral
    on tile[0]: app(i_tx, i_rx, i_i2c[0]);
  }
  return 0;
}

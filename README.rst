##############################
AN0xxxx: Bridging UART and I2C
##############################

:vendor: XMOS
:version: 1.0.0
:scope: Example
:description: This is a toy program showing how to connect two software defined peripherals
:category: General Purpose
:keywords: I2C, UART, protocol, serial, bridge, interface
:hardware: XK-EVK-XU316

*******
Summary
*******

This app note creates a fictional protocol bridge between I2C and UART to demonstrate the flexibility of 
the xcore platform when using software defined peripherals. The basic operation is that the UART will receive
(address,register) or (address',register,data) and read data from / write data to an I2C peripheral, returning
any results via the UART.

To build the app, navigate to the app_* folder and type:
  
  cmake -B build -G"Unix Makefiles"
  
  cd build
  
  xmake



********
Features
********

* UART with compile time configurable baud rate
* I2C master interface
* Simple app that forwards I2C commands / data over the UART


************
Known issues
************

* None

**************
Required tools
**************

* XMOS XTC Tools: 15.3.1

*********************************
Required libraries (dependencies)
*********************************

* lib_i2c
* lib_uart

**************************
Related application  notes
**************************

* `AN00000 - an00000 title <https://www.xmos.com/application-notes/an00000>`_
* `AN00001 - an00001 title <https://www.xmos.com/application-notes/an00001>`_

*******
Support
*******

This package is supported by XMOS Ltd. Issues can be raised against the software at:
http://www.xmos.com/support


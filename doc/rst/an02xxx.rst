##############################
AN02XXX: Simple application interfacing between UART and I2C
##############################

************
Introduction
************

Introduction text

***********
Section one
***********

Section one text

Sub-section
===========

Sub-section text

Another sub-section
===================

Another sub-section text

***********
Section two
***********

Section two text

Section two subsection
======================

Sub section text

Section two subsubsection
-------------------------

Sub sub section text

Another subsubsection
---------------------

Sub sub section text

*******************
Example application
*******************

Building the example
====================

This section assumes that the `XMOS XTC Tools <https://www.xmos.com/software-tools/>`_ have been
downloaded and installed. The required version is specified in the accompanying ``README``.

Installation instructions can be found `here <https://xmos.com/xtc-install-guide>`_.

Special attention should be paid to the section on
`Installation of Required Third-Party Tools <https://www.xmos.com/documentation/XM-014363-PC/html/installation/install-configure/install-tools/install_prerequisites.html>`_.

The application is built using the `xcommon-cmake <https://www.xmos.com/file/xcommon-cmake-documentation/?version=latest>`_
build system, which is provided with the XTC tools and is based on `CMake <https://cmake.org/>`_.

The ``an02xxx`` software ZIP package should be downloaded and extracted to a chosen working
directory.

To configure the build, the following commands should be run from an XTC command prompt::

    cd an02xxx
    cd app_an02xxx
    cmake -G "Unix Makefiles" -B build

All required dependencies are included in the software package. If any dependencies are missing,
they will be retrieved automatically during this step.

The application binaries should then be built using ``xmake``::

    xmake -j -C build

Binary artifacts (.xe files) will be generated under the appropriate subdirectories of the
``app_an02xxx/bin`` directory — one for each supported build configuration.

For subsequent builds, the ``cmake`` step may be omitted.
If ``CMakeLists.txt`` or other build files are modified, ``cmake`` will be re-run automatically
by ``xmake`` as needed.

===================
Running the example
===================

From an XTC command prompt, the following command should be run from the ``an02xxx/app_an02xxx``
directory::

    xrun ./bin/app_an02xxx.xe

Alternatively, the application can be programmed into flash memory for standalone execution::

    xflash ./bin/app_an02xxx.xe





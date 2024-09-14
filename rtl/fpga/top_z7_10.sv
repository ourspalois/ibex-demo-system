// inspired from work under Copyright lowRISC contributors.
// 			    Licensed under the Apache License, Version 2.0, see LICENSE for details.
// 			    SPDX-License-Identifier: Apache-2.0

// This is the top level SystemVerilog file that connects the IO on the zybo z7_10 board to the Ibex Demo System.
module top_zyboz7_10 #(
  parameter SRAMInitFile = ""
) (
  // These inputs are defined in data/pins_artya7.xdc
  input         IO_CLK,
  input         IO_RST,
  input  [ 3:0] SW,
  input  [ 2:0] BTN,
  output [ 3:0] LED,
  input         UART_RX,
  output        UART_TX
);

  logic clk ; 
  always_ff @(posedge(clk_sys)) begin 
    clk = ~clk ; 
  end

  logic clk_sys, rst_sys_n;
  logic RST_N ; 
  assign RST_N = ~IO_RST ;

  // Instantiating the Ibex Demo System.
  ibex_demo_system #(
    .GpiWidth     ( 7            ),
    .GpoWidth     ( 4            ),
    .PwmWidth     ( 0           ),
    .ClockFrequency(62_500_000),
    .SRAMInitFile ( SRAMInitFile )
  ) u_ibex_demo_system (
    //input
    .clk_sys_i (clk),
    .rst_sys_ni(rst_sys_n),
    .gp_i      ({SW, BTN}),
    .uart_rx_i (UART_RX),

    //output
    .gp_o     (LED),
    .pwm_o    (),
    .uart_tx_o(UART_TX),

    .spi_rx_i ('0),
    .spi_tx_o ('0),
    .spi_sck_o('0),

    .trst_ni(1'b1),
    .tms_i  (1'b0),
    .tck_i  (1'b0),
    .td_i   (1'b0),
    .td_o   ()
  );

  // Generating the system clock and reset for the FPGA.
  clkgen_xil7series clkgen(
    .IO_CLK(IO_CLK),
    .IO_RST_N(RST_N),
    .clk_sys,
    .rst_sys_n
  );

endmodule

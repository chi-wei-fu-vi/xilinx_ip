//------------------------------------------------------------------------------
//  (c) Copyright 2013-2015 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------


`timescale 1ps/1ps

// =====================================================================================================================
// This example design top module instantiates the example design wrapper; slices vectored ports for per-channel
// assignment; and instantiates example resources such as buffers, pattern generators, and pattern checkers for core
// demonstration purposes
// =====================================================================================================================

module gty_quad_example_top (
  input  wire  [15:0]                         cm0_drpaddr_common_int,
  //input  wire  [0:0]                          cm0_drpclk_common_int,
  input  wire  [0:0]                          drpclk,
  input  wire  [15:0]                         cm0_drpdi_common_int,
  input  wire  [0:0]                          cm0_drpen_common_int,
  input  wire  [0:0]                          cm0_drpwe_common_int,
  input  wire  [9:0]                          ch0_drpaddr_int,
  input  wire  [9:0]                          ch1_drpaddr_int,
  input  wire  [9:0]                          ch2_drpaddr_int,
  input  wire  [9:0]                          ch3_drpaddr_int,
  //input  wire  [0:0]                          ch0_drpclk_int,
  //input  wire  [0:0]                          ch1_drpclk_int,
  //input  wire  [0:0]                          ch2_drpclk_int,
  //input  wire  [0:0]                          ch3_drpclk_int,
  input  wire  [15:0]                         ch0_drpdi_int,
  input  wire  [15:0]                         ch1_drpdi_int,
  input  wire  [15:0]                         ch2_drpdi_int,
  input  wire  [15:0]                         ch3_drpdi_int,
  input  wire  [0:0]                          ch0_drpen_int,
  input  wire  [0:0]                          ch1_drpen_int,
  input  wire  [0:0]                          ch2_drpen_int,
  input  wire  [0:0]                          ch3_drpen_int,
  input  wire  [0:0]                          ch0_drpwe_int,
  input  wire  [0:0]                          ch1_drpwe_int,
  input  wire  [0:0]                          ch2_drpwe_int,
  input  wire  [0:0]                          ch3_drpwe_int,

  output wire  [0:0]                          cm0_gtrefclk00_int,
  output wire  [15:0]                         cm0_drpdo_common_int,
  output wire  [0:0]                          cm0_drprdy_common_int,
  output wire  [15:0]                         ch0_drpdo_int,
  output wire  [15:0]                         ch1_drpdo_int,
  output wire  [15:0]                         ch2_drpdo_int,
  output wire  [15:0]                         ch3_drpdo_int,
  output wire  [0:0]                          ch0_drprdy_int,
  output wire  [0:0]                          ch1_drprdy_int,
  output wire  [0:0]                          ch2_drprdy_int,
  output wire  [0:0]                          ch3_drprdy_int,

  // Differential reference clock inputs
  input  wire                                 mgtrefclk0_x0y2_p,
  input  wire                                 mgtrefclk0_x0y2_n,

  // Serial data ports for transceiver channel 0
  input  wire                                 ch0_gtyrxn_in,
  input  wire                                 ch0_gtyrxp_in,
  output wire                                 ch0_gtytxn_out,
  output wire                                 ch0_gtytxp_out,

  // Serial data ports for transceiver channel 1
  input  wire                                 ch1_gtyrxn_in,
  input  wire                                 ch1_gtyrxp_in,
  output wire                                 ch1_gtytxn_out,
  output wire                                 ch1_gtytxp_out,

  // Serial data ports for transceiver channel 2
  input  wire                                 ch2_gtyrxn_in,
  input  wire                                 ch2_gtyrxp_in,
  output wire                                 ch2_gtytxn_out,
  output wire                                 ch2_gtytxp_out,

  // Serial data ports for transceiver channel 3
  input  wire                                 ch3_gtyrxn_in,
  input  wire                                 ch3_gtyrxp_in,
  output wire                                 ch3_gtytxn_out,
  output wire                                 ch3_gtytxp_out,

  // User-provided ports for reset helper block(s)
  input  wire                                 hb_gtwiz_reset_clk_freerun_in,
  input  wire                                 hb_gtwiz_reset_all_in,

  // PRBS-based link status ports
  input  wire                                 link_down_latched_reset_in,
  output wire                                 link_status_out,
  output reg                                  link_down_latched_out = 1'b1 

);


  // ===================================================================================================================
  // PER-CHANNEL SIGNAL ASSIGNMENTS
  // ===================================================================================================================

  // The core and example design wrapper vectorize ports across all enabled transceiver channel and common instances for
  // simplicity and compactness. This example design top module assigns slices of each vector to individual, per-channel
  // signal vectors for use if desired. Signals which connect to helper blocks are prefixed "hb#", signals which connect
  // to transceiver common primitives are prefixed "cm#", and signals which connect to transceiver channel primitives
  // are prefixed "ch#", where "#" is the sequential resource number.

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] gtyrxn_int;
  assign gtyrxn_int[0:0] = ch0_gtyrxn_in;
  assign gtyrxn_int[1:1] = ch1_gtyrxn_in;
  assign gtyrxn_int[2:2] = ch2_gtyrxn_in;
  assign gtyrxn_int[3:3] = ch3_gtyrxn_in;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] gtyrxp_int;
  assign gtyrxp_int[0:0] = ch0_gtyrxp_in;
  assign gtyrxp_int[1:1] = ch1_gtyrxp_in;
  assign gtyrxp_int[2:2] = ch2_gtyrxp_in;
  assign gtyrxp_int[3:3] = ch3_gtyrxp_in;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] gtytxn_int;
  assign ch0_gtytxn_out = gtytxn_int[0:0];
  assign ch1_gtytxn_out = gtytxn_int[1:1];
  assign ch2_gtytxn_out = gtytxn_int[2:2];
  assign ch3_gtytxn_out = gtytxn_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] gtytxp_int;
  assign ch0_gtytxp_out = gtytxp_int[0:0];
  assign ch1_gtytxp_out = gtytxp_int[1:1];
  assign ch2_gtytxp_out = gtytxp_int[2:2];
  assign ch3_gtytxp_out = gtytxp_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_reset_int;
  wire [0:0] hb0_gtwiz_userclk_tx_reset_int;
  assign gtwiz_userclk_tx_reset_int[0:0] = hb0_gtwiz_userclk_tx_reset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_srcclk_int;
  wire [0:0] hb0_gtwiz_userclk_tx_srcclk_int;
  assign hb0_gtwiz_userclk_tx_srcclk_int = gtwiz_userclk_tx_srcclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_usrclk_int;
  wire [0:0] hb0_gtwiz_userclk_tx_usrclk_int;
  assign hb0_gtwiz_userclk_tx_usrclk_int = gtwiz_userclk_tx_usrclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_usrclk2_int;
  wire [0:0] hb0_gtwiz_userclk_tx_usrclk2_int;
  assign hb0_gtwiz_userclk_tx_usrclk2_int = gtwiz_userclk_tx_usrclk2_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_active_int;
  wire [0:0] hb0_gtwiz_userclk_tx_active_int;
  assign hb0_gtwiz_userclk_tx_active_int = gtwiz_userclk_tx_active_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_reset_int;
  wire [0:0] hb0_gtwiz_userclk_rx_reset_int;
  assign gtwiz_userclk_rx_reset_int[0:0] = hb0_gtwiz_userclk_rx_reset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_srcclk_int;
  wire [0:0] hb0_gtwiz_userclk_rx_srcclk_int;
  assign hb0_gtwiz_userclk_rx_srcclk_int = gtwiz_userclk_rx_srcclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_usrclk_int;
  wire [0:0] hb0_gtwiz_userclk_rx_usrclk_int;
  assign hb0_gtwiz_userclk_rx_usrclk_int = gtwiz_userclk_rx_usrclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_usrclk2_int;
  wire [0:0] hb0_gtwiz_userclk_rx_usrclk2_int;
  assign hb0_gtwiz_userclk_rx_usrclk2_int = gtwiz_userclk_rx_usrclk2_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_active_int;
  wire [0:0] hb0_gtwiz_userclk_rx_active_int;
  assign hb0_gtwiz_userclk_rx_active_int = gtwiz_userclk_rx_active_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_clk_freerun_int;
  wire [0:0] hb0_gtwiz_reset_clk_freerun_int = 1'b0;
  assign gtwiz_reset_clk_freerun_int[0:0] = hb0_gtwiz_reset_clk_freerun_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_all_int;
  wire [0:0] hb0_gtwiz_reset_all_int = 1'b0;
  assign gtwiz_reset_all_int[0:0] = hb0_gtwiz_reset_all_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_pll_and_datapath_int;
  wire [0:0] hb0_gtwiz_reset_tx_pll_and_datapath_int;
  assign gtwiz_reset_tx_pll_and_datapath_int[0:0] = hb0_gtwiz_reset_tx_pll_and_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_datapath_int;
  wire [0:0] hb0_gtwiz_reset_tx_datapath_int;
  assign gtwiz_reset_tx_datapath_int[0:0] = hb0_gtwiz_reset_tx_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_pll_and_datapath_int;
  wire [0:0] hb0_gtwiz_reset_rx_pll_and_datapath_int = 1'b0;
  assign gtwiz_reset_rx_pll_and_datapath_int[0:0] = hb0_gtwiz_reset_rx_pll_and_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_datapath_int;
  wire [0:0] hb0_gtwiz_reset_rx_datapath_int = 1'b0;
  assign gtwiz_reset_rx_datapath_int[0:0] = hb0_gtwiz_reset_rx_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_cdr_stable_int;
  wire [0:0] hb0_gtwiz_reset_rx_cdr_stable_int;
  assign hb0_gtwiz_reset_rx_cdr_stable_int = gtwiz_reset_rx_cdr_stable_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_done_int;
  wire [0:0] hb0_gtwiz_reset_tx_done_int;
  assign hb0_gtwiz_reset_tx_done_int = gtwiz_reset_tx_done_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_done_int;
  wire [0:0] hb0_gtwiz_reset_rx_done_int;
  assign hb0_gtwiz_reset_rx_done_int = gtwiz_reset_rx_done_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [319:0] gtwiz_userdata_tx_int;
  wire [79:0] hb0_gtwiz_userdata_tx_int;
  wire [79:0] hb1_gtwiz_userdata_tx_int;
  wire [79:0] hb2_gtwiz_userdata_tx_int;
  wire [79:0] hb3_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[79:0] = hb0_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[159:80] = hb1_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[239:160] = hb2_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[319:240] = hb3_gtwiz_userdata_tx_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [319:0] gtwiz_userdata_rx_int;
  wire [79:0] hb0_gtwiz_userdata_rx_int;
  wire [79:0] hb1_gtwiz_userdata_rx_int;
  wire [79:0] hb2_gtwiz_userdata_rx_int;
  wire [79:0] hb3_gtwiz_userdata_rx_int;
  assign hb0_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[79:0];
  assign hb1_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[159:80];
  assign hb2_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[239:160];
  assign hb3_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[319:240];

  //--------------------------------------------------------------------------------------------------------------------
  wire [15:0] drpaddr_common_int;
//  wire [15:0] cm0_drpaddr_common_int = 16'b0000000000000000;
  assign drpaddr_common_int[15:0] = cm0_drpaddr_common_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] drpclk_common_int;
//  wire [0:0] cm0_drpclk_common_int = 1'b0;
  assign drpclk_common_int[0:0] = drpclk;

  //--------------------------------------------------------------------------------------------------------------------
  wire [15:0] drpdi_common_int;
//  wire [15:0] cm0_drpdi_common_int = 16'b0000000000000000;
  assign drpdi_common_int[15:0] = cm0_drpdi_common_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] drpen_common_int;
//  wire [0:0] cm0_drpen_common_int = 1'b0;
  assign drpen_common_int[0:0] = cm0_drpen_common_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] drpwe_common_int;
//  wire [0:0] cm0_drpwe_common_int = 1'b0;
  assign drpwe_common_int[0:0] = cm0_drpwe_common_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtrefclk00_int;
//  wire [0:0] cm0_gtrefclk00_int;
  assign gtrefclk00_int[0:0] = cm0_gtrefclk00_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [15:0] drpdo_common_int;
//  wire [15:0] cm0_drpdo_common_int;
  assign cm0_drpdo_common_int = drpdo_common_int[15:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] drprdy_common_int;
//  wire [0:0] cm0_drprdy_common_int;
  assign cm0_drprdy_common_int = drprdy_common_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll0lock_int;
  wire [0:0] cm0_qpll0lock_int;
  assign cm0_qpll0lock_int = qpll0lock_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll0outclk_int;
  wire [0:0] cm0_qpll0outclk_int;
  assign cm0_qpll0outclk_int = qpll0outclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll0outrefclk_int;
  wire [0:0] cm0_qpll0outrefclk_int;
  assign cm0_qpll0outrefclk_int = qpll0outrefclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll1lock_int;
  wire [0:0] cm0_qpll1lock_int;
  assign cm0_qpll1lock_int = qpll1lock_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [39:0] drpaddr_int;
//  wire [9:0] ch0_drpaddr_int = 10'b0000000000;
//  wire [9:0] ch1_drpaddr_int = 10'b0000000000;
//  wire [9:0] ch2_drpaddr_int = 10'b0000000000;
//  wire [9:0] ch3_drpaddr_int = 10'b0000000000;
  assign drpaddr_int[9:0] = ch0_drpaddr_int;
  assign drpaddr_int[19:10] = ch1_drpaddr_int;
  assign drpaddr_int[29:20] = ch2_drpaddr_int;
  assign drpaddr_int[39:30] = ch3_drpaddr_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] drpclk_int;
//  wire [0:0] ch0_drpclk_int = 1'b0;
//  wire [0:0] ch1_drpclk_int = 1'b0;
//  wire [0:0] ch2_drpclk_int = 1'b0;
//  wire [0:0] ch3_drpclk_int = 1'b0;
  assign drpclk_int[0:0] = drpclk;
  assign drpclk_int[1:1] = drpclk;
  assign drpclk_int[2:2] = drpclk;
  assign drpclk_int[3:3] = drpclk;

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] drpdi_int;
//  wire [15:0] ch0_drpdi_int = 16'b0000000000000000;
//  wire [15:0] ch1_drpdi_int = 16'b0000000000000000;
//  wire [15:0] ch2_drpdi_int = 16'b0000000000000000;
//  wire [15:0] ch3_drpdi_int = 16'b0000000000000000;
  assign drpdi_int[15:0] = ch0_drpdi_int;
  assign drpdi_int[31:16] = ch1_drpdi_int;
  assign drpdi_int[47:32] = ch2_drpdi_int;
  assign drpdi_int[63:48] = ch3_drpdi_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] drpen_int;
//  wire [0:0] ch0_drpen_int = 1'b0;
//  wire [0:0] ch1_drpen_int = 1'b0;
//  wire [0:0] ch2_drpen_int = 1'b0;
//  wire [0:0] ch3_drpen_int = 1'b0;
  assign drpen_int[0:0] = ch0_drpen_int;
  assign drpen_int[1:1] = ch1_drpen_int;
  assign drpen_int[2:2] = ch2_drpen_int;
  assign drpen_int[3:3] = ch3_drpen_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] drpwe_int;
//  wire [0:0] ch0_drpwe_int = 1'b0;
//  wire [0:0] ch1_drpwe_int = 1'b0;
//  wire [0:0] ch2_drpwe_int = 1'b0;
//  wire [0:0] ch3_drpwe_int = 1'b0;
  assign drpwe_int[0:0] = ch0_drpwe_int;
  assign drpwe_int[1:1] = ch1_drpwe_int;
  assign drpwe_int[2:2] = ch2_drpwe_int;
  assign drpwe_int[3:3] = ch3_drpwe_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] eyescanreset_int;
  wire [0:0] ch0_eyescanreset_int = 1'b0;
  wire [0:0] ch1_eyescanreset_int = 1'b0;
  wire [0:0] ch2_eyescanreset_int = 1'b0;
  wire [0:0] ch3_eyescanreset_int = 1'b0;
  assign eyescanreset_int[0:0] = ch0_eyescanreset_int;
  assign eyescanreset_int[1:1] = ch1_eyescanreset_int;
  assign eyescanreset_int[2:2] = ch2_eyescanreset_int;
  assign eyescanreset_int[3:3] = ch3_eyescanreset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] eyescantrigger_int;
  wire [0:0] ch0_eyescantrigger_int = 1'b0;
  wire [0:0] ch1_eyescantrigger_int = 1'b0;
  wire [0:0] ch2_eyescantrigger_int = 1'b0;
  wire [0:0] ch3_eyescantrigger_int = 1'b0;
  assign eyescantrigger_int[0:0] = ch0_eyescantrigger_int;
  assign eyescantrigger_int[1:1] = ch1_eyescantrigger_int;
  assign eyescantrigger_int[2:2] = ch2_eyescantrigger_int;
  assign eyescantrigger_int[3:3] = ch3_eyescantrigger_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [11:0] loopback_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] pcsrsvdin_int;
  wire [15:0] ch0_pcsrsvdin_int = 16'b0000000000000000;
  wire [15:0] ch1_pcsrsvdin_int = 16'b0000000000000000;
  wire [15:0] ch2_pcsrsvdin_int = 16'b0000000000000000;
  wire [15:0] ch3_pcsrsvdin_int = 16'b0000000000000000;
  assign pcsrsvdin_int[15:0] = ch0_pcsrsvdin_int;
  assign pcsrsvdin_int[31:16] = ch1_pcsrsvdin_int;
  assign pcsrsvdin_int[47:32] = ch2_pcsrsvdin_int;
  assign pcsrsvdin_int[63:48] = ch3_pcsrsvdin_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxbufreset_int;
  wire [0:0] ch0_rxbufreset_int = 1'b0;
  wire [0:0] ch1_rxbufreset_int = 1'b0;
  wire [0:0] ch2_rxbufreset_int = 1'b0;
  wire [0:0] ch3_rxbufreset_int = 1'b0;
  assign rxbufreset_int[0:0] = ch0_rxbufreset_int;
  assign rxbufreset_int[1:1] = ch1_rxbufreset_int;
  assign rxbufreset_int[2:2] = ch2_rxbufreset_int;
  assign rxbufreset_int[3:3] = ch3_rxbufreset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxcdrhold_int;
  wire [0:0] ch0_rxcdrhold_int = 1'b0;
  wire [0:0] ch1_rxcdrhold_int = 1'b0;
  wire [0:0] ch2_rxcdrhold_int = 1'b0;
  wire [0:0] ch3_rxcdrhold_int = 1'b0;
  assign rxcdrhold_int[0:0] = ch0_rxcdrhold_int;
  assign rxcdrhold_int[1:1] = ch1_rxcdrhold_int;
  assign rxcdrhold_int[2:2] = ch2_rxcdrhold_int;
  assign rxcdrhold_int[3:3] = ch3_rxcdrhold_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxdfelpmreset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxlpmen_int;
  wire [0:0] ch0_rxlpmen_int = 1'b1;
  wire [0:0] ch1_rxlpmen_int = 1'b1;
  wire [0:0] ch2_rxlpmen_int = 1'b1;
  wire [0:0] ch3_rxlpmen_int = 1'b1;
  assign rxlpmen_int[0:0] = ch0_rxlpmen_int;
  assign rxlpmen_int[1:1] = ch1_rxlpmen_int;
  assign rxlpmen_int[2:2] = ch2_rxlpmen_int;
  assign rxlpmen_int[3:3] = ch3_rxlpmen_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxpcsreset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxpmareset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxpolarity_int;
  wire [0:0] ch0_rxpolarity_int = 1'b0;
  wire [0:0] ch1_rxpolarity_int = 1'b0;
  wire [0:0] ch2_rxpolarity_int = 1'b0;
  wire [0:0] ch3_rxpolarity_int = 1'b0;
  assign rxpolarity_int[0:0] = ch0_rxpolarity_int;
  assign rxpolarity_int[1:1] = ch1_rxpolarity_int;
  assign rxpolarity_int[2:2] = ch2_rxpolarity_int;
  assign rxpolarity_int[3:3] = ch3_rxpolarity_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxprbscntreset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [15:0] rxprbssel_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [11:0] rxrate_int;
  wire [2:0] ch0_rxrate_int = 3'b000;
  wire [2:0] ch1_rxrate_int = 3'b000;
  wire [2:0] ch2_rxrate_int = 3'b000;
  wire [2:0] ch3_rxrate_int = 3'b000;
  assign rxrate_int[2:0] = ch0_rxrate_int;
  assign rxrate_int[5:3] = ch1_rxrate_int;
  assign rxrate_int[8:6] = ch2_rxrate_int;
  assign rxrate_int[11:9] = ch3_rxrate_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] txdiffctrl_int;
  wire [4:0] ch0_txdiffctrl_int = 5'b11000;
  wire [4:0] ch1_txdiffctrl_int = 5'b11000;
  wire [4:0] ch2_txdiffctrl_int = 5'b11000;
  wire [4:0] ch3_txdiffctrl_int = 5'b11000;
  assign txdiffctrl_int[4:0] = ch0_txdiffctrl_int;
  assign txdiffctrl_int[9:5] = ch1_txdiffctrl_int;
  assign txdiffctrl_int[14:10] = ch2_txdiffctrl_int;
  assign txdiffctrl_int[19:15] = ch3_txdiffctrl_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txinhibit_int;
  wire [0:0] ch0_txinhibit_int = 1'b0;
  wire [0:0] ch1_txinhibit_int = 1'b0;
  wire [0:0] ch2_txinhibit_int = 1'b0;
  wire [0:0] ch3_txinhibit_int = 1'b0;
  assign txinhibit_int[0:0] = ch0_txinhibit_int;
  assign txinhibit_int[1:1] = ch1_txinhibit_int;
  assign txinhibit_int[2:2] = ch2_txinhibit_int;
  assign txinhibit_int[3:3] = ch3_txinhibit_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txpcsreset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txpmareset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txpolarity_int;
  wire [0:0] ch0_txpolarity_int = 1'b0;
  wire [0:0] ch1_txpolarity_int = 1'b0;
  wire [0:0] ch2_txpolarity_int = 1'b0;
  wire [0:0] ch3_txpolarity_int = 1'b0;
  assign txpolarity_int[0:0] = ch0_txpolarity_int;
  assign txpolarity_int[1:1] = ch1_txpolarity_int;
  assign txpolarity_int[2:2] = ch2_txpolarity_int;
  assign txpolarity_int[3:3] = ch3_txpolarity_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] txpostcursor_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txprbsforceerr_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [15:0] txprbssel_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] txprecursor_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] cplllock_int;
  wire [0:0] ch0_cplllock_int;
  wire [0:0] ch1_cplllock_int;
  wire [0:0] ch2_cplllock_int;
  wire [0:0] ch3_cplllock_int;
  assign ch0_cplllock_int = cplllock_int[0:0];
  assign ch1_cplllock_int = cplllock_int[1:1];
  assign ch2_cplllock_int = cplllock_int[2:2];
  assign ch3_cplllock_int = cplllock_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] dmonitorout_int;
  wire [15:0] ch0_dmonitorout_int;
  wire [15:0] ch1_dmonitorout_int;
  wire [15:0] ch2_dmonitorout_int;
  wire [15:0] ch3_dmonitorout_int;
  assign ch0_dmonitorout_int = dmonitorout_int[15:0];
  assign ch1_dmonitorout_int = dmonitorout_int[31:16];
  assign ch2_dmonitorout_int = dmonitorout_int[47:32];
  assign ch3_dmonitorout_int = dmonitorout_int[63:48];

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] drpdo_int;
  wire [15:0] ch0_drpdo_int;
  wire [15:0] ch1_drpdo_int;
  wire [15:0] ch2_drpdo_int;
  wire [15:0] ch3_drpdo_int;
  assign ch0_drpdo_int = drpdo_int[15:0];
  assign ch1_drpdo_int = drpdo_int[31:16];
  assign ch2_drpdo_int = drpdo_int[47:32];
  assign ch3_drpdo_int = drpdo_int[63:48];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] drprdy_int;
  wire [0:0] ch0_drprdy_int;
  wire [0:0] ch1_drprdy_int;
  wire [0:0] ch2_drprdy_int;
  wire [0:0] ch3_drprdy_int;
  assign ch0_drprdy_int = drprdy_int[0:0];
  assign ch1_drprdy_int = drprdy_int[1:1];
  assign ch2_drprdy_int = drprdy_int[2:2];
  assign ch3_drprdy_int = drprdy_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] eyescandataerror_int;
  wire [0:0] ch0_eyescandataerror_int;
  wire [0:0] ch1_eyescandataerror_int;
  wire [0:0] ch2_eyescandataerror_int;
  wire [0:0] ch3_eyescandataerror_int;
  assign ch0_eyescandataerror_int = eyescandataerror_int[0:0];
  assign ch1_eyescandataerror_int = eyescandataerror_int[1:1];
  assign ch2_eyescandataerror_int = eyescandataerror_int[2:2];
  assign ch3_eyescandataerror_int = eyescandataerror_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] gtpowergood_int;
  wire [0:0] ch0_gtpowergood_int;
  wire [0:0] ch1_gtpowergood_int;
  wire [0:0] ch2_gtpowergood_int;
  wire [0:0] ch3_gtpowergood_int;
  assign ch0_gtpowergood_int = gtpowergood_int[0:0];
  assign ch1_gtpowergood_int = gtpowergood_int[1:1];
  assign ch2_gtpowergood_int = gtpowergood_int[2:2];
  assign ch3_gtpowergood_int = gtpowergood_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [11:0] rxbufstatus_int;
  wire [2:0] ch0_rxbufstatus_int;
  wire [2:0] ch1_rxbufstatus_int;
  wire [2:0] ch2_rxbufstatus_int;
  wire [2:0] ch3_rxbufstatus_int;
  assign ch0_rxbufstatus_int = rxbufstatus_int[2:0];
  assign ch1_rxbufstatus_int = rxbufstatus_int[5:3];
  assign ch2_rxbufstatus_int = rxbufstatus_int[8:6];
  assign ch3_rxbufstatus_int = rxbufstatus_int[11:9];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxcommadet_int;
  wire [0:0] ch0_rxcommadet_int;
  wire [0:0] ch1_rxcommadet_int;
  wire [0:0] ch2_rxcommadet_int;
  wire [0:0] ch3_rxcommadet_int;
  assign ch0_rxcommadet_int = rxcommadet_int[0:0];
  assign ch1_rxcommadet_int = rxcommadet_int[1:1];
  assign ch2_rxcommadet_int = rxcommadet_int[2:2];
  assign ch3_rxcommadet_int = rxcommadet_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] rxctrl1_int;
  wire [15:0] ch0_rxctrl1_int;
  wire [15:0] ch1_rxctrl1_int;
  wire [15:0] ch2_rxctrl1_int;
  wire [15:0] ch3_rxctrl1_int;
  assign ch0_rxctrl1_int = rxctrl1_int[15:0];
  assign ch1_rxctrl1_int = rxctrl1_int[31:16];
  assign ch2_rxctrl1_int = rxctrl1_int[47:32];
  assign ch3_rxctrl1_int = rxctrl1_int[63:48];

  //--------------------------------------------------------------------------------------------------------------------
  wire [31:0] rxctrl3_int;
  wire [7:0] ch0_rxctrl3_int;
  wire [7:0] ch1_rxctrl3_int;
  wire [7:0] ch2_rxctrl3_int;
  wire [7:0] ch3_rxctrl3_int;
  assign ch0_rxctrl3_int = rxctrl3_int[7:0];
  assign ch1_rxctrl3_int = rxctrl3_int[15:8];
  assign ch2_rxctrl3_int = rxctrl3_int[23:16];
  assign ch3_rxctrl3_int = rxctrl3_int[31:24];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxdlysresetdone_int;
  wire [0:0] ch0_rxdlysresetdone_int;
  wire [0:0] ch1_rxdlysresetdone_int;
  wire [0:0] ch2_rxdlysresetdone_int;
  wire [0:0] ch3_rxdlysresetdone_int;
  assign ch0_rxdlysresetdone_int = rxdlysresetdone_int[0:0];
  assign ch1_rxdlysresetdone_int = rxdlysresetdone_int[1:1];
  assign ch2_rxdlysresetdone_int = rxdlysresetdone_int[2:2];
  assign ch3_rxdlysresetdone_int = rxdlysresetdone_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxphaligndone_int;
  wire [0:0] ch0_rxphaligndone_int;
  wire [0:0] ch1_rxphaligndone_int;
  wire [0:0] ch2_rxphaligndone_int;
  wire [0:0] ch3_rxphaligndone_int;
  assign ch0_rxphaligndone_int = rxphaligndone_int[0:0];
  assign ch1_rxphaligndone_int = rxphaligndone_int[1:1];
  assign ch2_rxphaligndone_int = rxphaligndone_int[2:2];
  assign ch3_rxphaligndone_int = rxphaligndone_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxpmaresetdone_int;
  wire [0:0] ch0_rxpmaresetdone_int;
  wire [0:0] ch1_rxpmaresetdone_int;
  wire [0:0] ch2_rxpmaresetdone_int;
  wire [0:0] ch3_rxpmaresetdone_int;
  assign ch0_rxpmaresetdone_int = rxpmaresetdone_int[0:0];
  assign ch1_rxpmaresetdone_int = rxpmaresetdone_int[1:1];
  assign ch2_rxpmaresetdone_int = rxpmaresetdone_int[2:2];
  assign ch3_rxpmaresetdone_int = rxpmaresetdone_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxprbserr_int;
  wire [0:0] ch0_rxprbserr_int;
  wire [0:0] ch1_rxprbserr_int;
  wire [0:0] ch2_rxprbserr_int;
  wire [0:0] ch3_rxprbserr_int;
  assign ch0_rxprbserr_int = rxprbserr_int[0:0];
  assign ch1_rxprbserr_int = rxprbserr_int[1:1];
  assign ch2_rxprbserr_int = rxprbserr_int[2:2];
  assign ch3_rxprbserr_int = rxprbserr_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxresetdone_int;
  wire [0:0] ch0_rxresetdone_int;
  wire [0:0] ch1_rxresetdone_int;
  wire [0:0] ch2_rxresetdone_int;
  wire [0:0] ch3_rxresetdone_int;
  assign ch0_rxresetdone_int = rxresetdone_int[0:0];
  assign ch1_rxresetdone_int = rxresetdone_int[1:1];
  assign ch2_rxresetdone_int = rxresetdone_int[2:2];
  assign ch3_rxresetdone_int = rxresetdone_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxsyncdone_int;
  wire [0:0] ch0_rxsyncdone_int;
  wire [0:0] ch1_rxsyncdone_int;
  wire [0:0] ch2_rxsyncdone_int;
  wire [0:0] ch3_rxsyncdone_int;
  assign ch0_rxsyncdone_int = rxsyncdone_int[0:0];
  assign ch1_rxsyncdone_int = rxsyncdone_int[1:1];
  assign ch2_rxsyncdone_int = rxsyncdone_int[2:2];
  assign ch3_rxsyncdone_int = rxsyncdone_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [7:0] txbufstatus_int;
  wire [1:0] ch0_txbufstatus_int;
  wire [1:0] ch1_txbufstatus_int;
  wire [1:0] ch2_txbufstatus_int;
  wire [1:0] ch3_txbufstatus_int;
  assign ch0_txbufstatus_int = txbufstatus_int[1:0];
  assign ch1_txbufstatus_int = txbufstatus_int[3:2];
  assign ch2_txbufstatus_int = txbufstatus_int[5:4];
  assign ch3_txbufstatus_int = txbufstatus_int[7:6];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txdlysresetdone_int;
  wire [0:0] ch0_txdlysresetdone_int;
  wire [0:0] ch1_txdlysresetdone_int;
  wire [0:0] ch2_txdlysresetdone_int;
  wire [0:0] ch3_txdlysresetdone_int;
  assign ch0_txdlysresetdone_int = txdlysresetdone_int[0:0];
  assign ch1_txdlysresetdone_int = txdlysresetdone_int[1:1];
  assign ch2_txdlysresetdone_int = txdlysresetdone_int[2:2];
  assign ch3_txdlysresetdone_int = txdlysresetdone_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txphaligndone_int;
  wire [0:0] ch0_txphaligndone_int;
  wire [0:0] ch1_txphaligndone_int;
  wire [0:0] ch2_txphaligndone_int;
  wire [0:0] ch3_txphaligndone_int;
  assign ch0_txphaligndone_int = txphaligndone_int[0:0];
  assign ch1_txphaligndone_int = txphaligndone_int[1:1];
  assign ch2_txphaligndone_int = txphaligndone_int[2:2];
  assign ch3_txphaligndone_int = txphaligndone_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txphinitdone_int;
  wire [0:0] ch0_txphinitdone_int;
  wire [0:0] ch1_txphinitdone_int;
  wire [0:0] ch2_txphinitdone_int;
  wire [0:0] ch3_txphinitdone_int;
  assign ch0_txphinitdone_int = txphinitdone_int[0:0];
  assign ch1_txphinitdone_int = txphinitdone_int[1:1];
  assign ch2_txphinitdone_int = txphinitdone_int[2:2];
  assign ch3_txphinitdone_int = txphinitdone_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txpmaresetdone_int;
  wire [0:0] ch0_txpmaresetdone_int;
  wire [0:0] ch1_txpmaresetdone_int;
  wire [0:0] ch2_txpmaresetdone_int;
  wire [0:0] ch3_txpmaresetdone_int;
  assign ch0_txpmaresetdone_int = txpmaresetdone_int[0:0];
  assign ch1_txpmaresetdone_int = txpmaresetdone_int[1:1];
  assign ch2_txpmaresetdone_int = txpmaresetdone_int[2:2];
  assign ch3_txpmaresetdone_int = txpmaresetdone_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txresetdone_int;
  wire [0:0] ch0_txresetdone_int;
  wire [0:0] ch1_txresetdone_int;
  wire [0:0] ch2_txresetdone_int;
  wire [0:0] ch3_txresetdone_int;
  assign ch0_txresetdone_int = txresetdone_int[0:0];
  assign ch1_txresetdone_int = txresetdone_int[1:1];
  assign ch2_txresetdone_int = txresetdone_int[2:2];
  assign ch3_txresetdone_int = txresetdone_int[3:3];


  // ===================================================================================================================
  // BUFFERS
  // ===================================================================================================================

  // Buffer the hb_gtwiz_reset_all_in input and logically combine it with the internal signal from the example
  // initialization block as well as the VIO-sourced reset
  wire hb_gtwiz_reset_all_vio_int;
  wire hb_gtwiz_reset_all_buf_int;
  wire hb_gtwiz_reset_all_init_int;
  wire hb_gtwiz_reset_all_int;

  IBUF ibuf_hb_gtwiz_reset_all_inst (
    .I (hb_gtwiz_reset_all_in),
    .O (hb_gtwiz_reset_all_buf_int)
  );

  assign hb_gtwiz_reset_all_int = hb_gtwiz_reset_all_buf_int || hb_gtwiz_reset_all_init_int || hb_gtwiz_reset_all_vio_int;

  // Globally buffer the free-running input clock
  wire hb_gtwiz_reset_clk_freerun_buf_int;

  BUFG bufg_clk_freerun_inst (
    .I (hb_gtwiz_reset_clk_freerun_in),
    .O (hb_gtwiz_reset_clk_freerun_buf_int)
  );

  // Instantiate a differential reference clock buffer for each reference clock differential pair in this configuration,
  // and assign the single-ended output of each differential reference clock buffer to the appropriate PLL input signal

  // Differential reference clock buffer for MGTREFCLK0_X0Y2
  wire mgtrefclk0_x0y2_int;

  IBUFDS_GTE4 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE4_MGTREFCLK0_X0Y2_INST (
    .I     (mgtrefclk0_x0y2_p),
    .IB    (mgtrefclk0_x0y2_n),
    .CEB   (1'b0),
    .O     (mgtrefclk0_x0y2_int),
    .ODIV2 ()
  );

  assign cm0_gtrefclk00_int = mgtrefclk0_x0y2_int;


  // ===================================================================================================================
  // USER CLOCKING RESETS
  // ===================================================================================================================

  // The TX user clocking helper block should be held in reset until the clock source of that block is known to be
  // stable. The following assignment is an example of how that stability can be determined, based on the selected TX
  // user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  assign hb0_gtwiz_userclk_tx_reset_int = ~(&txpmaresetdone_int);

  // The RX user clocking helper block should be held in reset until the clock source of that block is known to be
  // stable. The following assignment is an example of how that stability can be determined, based on the selected RX
  // user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  assign hb0_gtwiz_userclk_rx_reset_int = ~(&rxpmaresetdone_int);


  // ===================================================================================================================
  // PRBS STIMULUS, CHECKING, AND LINK MANAGEMENT
  // ===================================================================================================================

  // PRBS stimulus
  // -------------------------------------------------------------------------------------------------------------------

  // PRBS-based data stimulus module for transceiver channel 0
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_stimulus_raw example_stimulus_inst0 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txdata_out                  (hb0_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 1
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_stimulus_raw example_stimulus_inst1 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txdata_out                  (hb1_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 2
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_stimulus_raw example_stimulus_inst2 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txdata_out                  (hb2_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 3
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_stimulus_raw example_stimulus_inst3 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txdata_out                  (hb3_gtwiz_userdata_tx_int)
  );

  // PRBS checking
  // -------------------------------------------------------------------------------------------------------------------

  // Declare a signal vector of PRBS match indicators, with one indicator bit per transceiver channel
  wire [3:0] prbs_match_int;

  // PRBS-based data checking module for transceiver channel 0
  gty_quad_example_checking_raw example_checking_inst0 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxdata_in                   (hb0_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[0])
  );

  // PRBS-based data checking module for transceiver channel 1
  gty_quad_example_checking_raw example_checking_inst1 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxdata_in                   (hb1_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[1])
  );

  // PRBS-based data checking module for transceiver channel 2
  gty_quad_example_checking_raw example_checking_inst2 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxdata_in                   (hb2_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[2])
  );

  // PRBS-based data checking module for transceiver channel 3
  gty_quad_example_checking_raw example_checking_inst3 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxdata_in                   (hb3_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[3])
  );

  // PRBS match and related link management
  // -------------------------------------------------------------------------------------------------------------------

  // Perform a bitwise NAND of all PRBS match indicators, creating a combinatorial indication of any PRBS mismatch
  // across all transceiver channels
  wire prbs_error_any_async = ~(&prbs_match_int);
  wire prbs_error_any_sync;

  // Synchronize the PRBS mismatch indicator the free-running clock domain, using a reset synchronizer with asynchronous
  // reset and synchronous removal
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_reset_synchronizer reset_synchronizer_prbs_match_all_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .rst_in (prbs_error_any_async),
    .rst_out(prbs_error_any_sync)
  );

  // Implement an example link status state machine using a simple leaky bucket mechanism. The link status indicates
  // the continual PRBS match status to both the top-level observer and the initialization state machine, while being
  // tolerant of occasional bit errors. This is an example and can be modified as necessary.
  localparam ST_LINK_DOWN = 1'b0;
  localparam ST_LINK_UP   = 1'b1;
  reg        sm_link      = ST_LINK_DOWN;
  reg [6:0]  link_ctr     = 7'd0;

  always @(posedge hb_gtwiz_reset_clk_freerun_buf_int) begin
    case (sm_link)
      // The link is considered to be down when the link counter initially has a value less than 67. When the link is
      // down, the counter is incremented on each cycle where all PRBS bits match, but reset whenever any PRBS mismatch
      // occurs. When the link counter reaches 67, transition to the link up state.
      ST_LINK_DOWN: begin
        if (prbs_error_any_sync !== 1'b0) begin
          link_ctr <= 7'd0;
        end
        else begin
          if (link_ctr < 7'd67)
            link_ctr <= link_ctr + 7'd1;
          else
            sm_link <= ST_LINK_UP;
        end
      end

      // When the link is up, the link counter is decreased by 34 whenever any PRBS mismatch occurs, but is increased by
      // only 1 on each cycle where all PRBS bits match, up to its saturation point of 67. If the link counter reaches
      // 0 (including rollover protection), transition to the link down state.
      ST_LINK_UP: begin
        if (prbs_error_any_sync !== 1'b0) begin
          if (link_ctr > 7'd33) begin
            link_ctr <= link_ctr - 7'd34;
            if (link_ctr == 7'd34)
              sm_link  <= ST_LINK_DOWN;
          end
          else begin
            link_ctr <= 7'd0;
            sm_link  <= ST_LINK_DOWN;
          end
        end
        else begin
          if (link_ctr < 7'd67)
            link_ctr <= link_ctr + 7'd1;
        end
      end
    endcase
  end

  // Synchronize the latched link down reset input and the VIO-driven signal into the free-running clock domain
  wire link_down_latched_reset_vio_int;
  wire link_down_latched_reset_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_link_down_latched_reset_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (link_down_latched_reset_in || link_down_latched_reset_vio_int),
    .o_out  (link_down_latched_reset_sync)
  );

  // Reset the latched link down indicator when the synchronized latched link down reset signal is high. Otherwise, set
  // the latched link down indicator upon losing link. This indicator is available for user reference.
  always @(posedge hb_gtwiz_reset_clk_freerun_buf_int) begin
    if (link_down_latched_reset_sync)
      link_down_latched_out <= 1'b0;
    else if (!sm_link)
      link_down_latched_out <= 1'b1;
  end

  // Assign the link status indicator to the top-level two-state output for user reference
  assign link_status_out = sm_link;


  // ===================================================================================================================
  // INITIALIZATION
  // ===================================================================================================================

  // Declare the receiver reset signals that interface to the reset controller helper block. For this configuration,
  // which uses the same PLL type for transmitter and receiver, the "reset RX PLL and datapath" feature is not used.
  wire hb_gtwiz_reset_rx_pll_and_datapath_int = 1'b0;
  wire hb_gtwiz_reset_rx_datapath_int;

  // Declare signals which connect the VIO instance to the initialization module for debug purposes
  wire       init_done_int;
  wire [3:0] init_retry_ctr_int;

  // Combine the receiver reset signals form the initialization module and the VIO to drive the appropriate reset
  // controller helper block reset input
  wire hb_gtwiz_reset_rx_pll_and_datapath_vio_int;
  wire hb_gtwiz_reset_rx_datapath_vio_int;
  wire hb_gtwiz_reset_rx_datapath_init_int;

  assign hb_gtwiz_reset_rx_datapath_int = hb_gtwiz_reset_rx_datapath_init_int || hb_gtwiz_reset_rx_datapath_vio_int;

  // The example initialization module interacts with the reset controller helper block and other example design logic
  // to retry failed reset attempts in order to mitigate bring-up issues such as initially-unavilable reference clocks
  // or data connections. It also resets the receiver in the event of link loss in an attempt to regain link, so please
  // note the possibility that this behavior can have the effect of overriding or disturbing user-provided inputs that
  // destabilize the data stream. It is a demonstration only and can be modified to suit your system needs.
  gty_quad_example_init example_init_inst (
    .clk_freerun_in  (hb_gtwiz_reset_clk_freerun_buf_int),
    .reset_all_in    (hb_gtwiz_reset_all_int),
    .tx_init_done_in (gtwiz_reset_tx_done_int),
    .rx_init_done_in (gtwiz_reset_rx_done_int),
    .rx_data_good_in (sm_link),
    .reset_all_out   (hb_gtwiz_reset_all_init_int),
    .reset_rx_out    (hb_gtwiz_reset_rx_datapath_init_int),
    .init_done_out   (init_done_int),
    .retry_ctr_out   (init_retry_ctr_int)
  );


  // ===================================================================================================================
  // VIO FOR HARDWARE BRING-UP AND DEBUG
  // ===================================================================================================================

  // Synchronize gtpowergood into the free-running clock domain for VIO usage
  wire [3:0] gtpowergood_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_gtpowergood_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtpowergood_int[0]),
    .o_out  (gtpowergood_vio_sync[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_gtpowergood_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtpowergood_int[1]),
    .o_out  (gtpowergood_vio_sync[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_gtpowergood_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtpowergood_int[2]),
    .o_out  (gtpowergood_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_gtpowergood_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtpowergood_int[3]),
    .o_out  (gtpowergood_vio_sync[3])
  );

  // Synchronize qpll0lock into the free-running clock domain for VIO usage
  wire [0:0] qpll0lock_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_qpll0lock_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (qpll0lock_int[0]),
    .o_out  (qpll0lock_vio_sync[0])
  );

  // Synchronize qpll1lock into the free-running clock domain for VIO usage
  wire [0:0] qpll1lock_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_qpll1lock_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (qpll1lock_int[0]),
    .o_out  (qpll1lock_vio_sync[0])
  );

  // Synchronize cplllock into the free-running clock domain for VIO usage
  wire [3:0] cplllock_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_cplllock_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (cplllock_int[0]),
    .o_out  (cplllock_vio_sync[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_cplllock_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (cplllock_int[1]),
    .o_out  (cplllock_vio_sync[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_cplllock_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (cplllock_int[2]),
    .o_out  (cplllock_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_cplllock_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (cplllock_int[3]),
    .o_out  (cplllock_vio_sync[3])
  );

  // Synchronize txpmaresetdone into the free-running clock domain for VIO usage
  wire [3:0] txpmaresetdone_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[0]),
    .o_out  (txpmaresetdone_vio_sync[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[1]),
    .o_out  (txpmaresetdone_vio_sync[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[2]),
    .o_out  (txpmaresetdone_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[3]),
    .o_out  (txpmaresetdone_vio_sync[3])
  );

  // Synchronize rxpmaresetdone into the free-running clock domain for VIO usage
  wire [3:0] rxpmaresetdone_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[0]),
    .o_out  (rxpmaresetdone_vio_sync[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[1]),
    .o_out  (rxpmaresetdone_vio_sync[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[2]),
    .o_out  (rxpmaresetdone_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[3]),
    .o_out  (rxpmaresetdone_vio_sync[3])
  );

  // Synchronize gtwiz_reset_tx_done into the free-running clock domain for VIO usage
  wire [0:0] gtwiz_reset_tx_done_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_gtwiz_reset_tx_done_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtwiz_reset_tx_done_int[0]),
    .o_out  (gtwiz_reset_tx_done_vio_sync[0])
  );

  // Synchronize gtwiz_reset_rx_done into the free-running clock domain for VIO usage
  wire [0:0] gtwiz_reset_rx_done_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_gtwiz_reset_rx_done_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtwiz_reset_rx_done_int[0]),
    .o_out  (gtwiz_reset_rx_done_vio_sync[0])
  );

  // Synchronize rxbufstatus into the free-running clock domain for VIO usage
  wire [11:0] rxbufstatus_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[0]),
    .o_out  (rxbufstatus_vio_sync[0])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[1]),
    .o_out  (rxbufstatus_vio_sync[1])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[2]),
    .o_out  (rxbufstatus_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[3]),
    .o_out  (rxbufstatus_vio_sync[3])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_4_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[4]),
    .o_out  (rxbufstatus_vio_sync[4])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_5_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[5]),
    .o_out  (rxbufstatus_vio_sync[5])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_6_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[6]),
    .o_out  (rxbufstatus_vio_sync[6])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_7_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[7]),
    .o_out  (rxbufstatus_vio_sync[7])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_8_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[8]),
    .o_out  (rxbufstatus_vio_sync[8])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_9_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[9]),
    .o_out  (rxbufstatus_vio_sync[9])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_10_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[10]),
    .o_out  (rxbufstatus_vio_sync[10])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_11_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[11]),
    .o_out  (rxbufstatus_vio_sync[11])
  );

  // Synchronize rxprbserr into the free-running clock domain for VIO usage
  wire [3:0] rxprbserr_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbserr_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxprbserr_int[0]),
    .o_out  (rxprbserr_vio_sync[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbserr_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxprbserr_int[1]),
    .o_out  (rxprbserr_vio_sync[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbserr_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxprbserr_int[2]),
    .o_out  (rxprbserr_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbserr_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxprbserr_int[3]),
    .o_out  (rxprbserr_vio_sync[3])
  );

  // Synchronize txprbssel into the TXUSRCLK2 clock domain from VIO usage
  wire [15:0] txprbssel_vio_async;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_0_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[0]),
    .o_out  (txprbssel_int[0])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_1_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[1]),
    .o_out  (txprbssel_int[1])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_2_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[2]),
    .o_out  (txprbssel_int[2])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_3_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[3]),
    .o_out  (txprbssel_int[3])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_4_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[4]),
    .o_out  (txprbssel_int[4])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_5_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[5]),
    .o_out  (txprbssel_int[5])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_6_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[6]),
    .o_out  (txprbssel_int[6])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_7_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[7]),
    .o_out  (txprbssel_int[7])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_8_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[8]),
    .o_out  (txprbssel_int[8])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_9_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[9]),
    .o_out  (txprbssel_int[9])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_10_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[10]),
    .o_out  (txprbssel_int[10])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_11_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[11]),
    .o_out  (txprbssel_int[11])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_12_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[12]),
    .o_out  (txprbssel_int[12])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_13_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[13]),
    .o_out  (txprbssel_int[13])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_14_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[14]),
    .o_out  (txprbssel_int[14])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbssel_15_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[15]),
    .o_out  (txprbssel_int[15])
  );

  // Synchronize rxprbssel into the RXUSRCLK2 clock domain from VIO usage
  wire [15:0] rxprbssel_vio_async;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_0_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[0]),
    .o_out  (rxprbssel_int[0])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_1_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[1]),
    .o_out  (rxprbssel_int[1])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_2_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[2]),
    .o_out  (rxprbssel_int[2])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_3_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[3]),
    .o_out  (rxprbssel_int[3])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_4_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[4]),
    .o_out  (rxprbssel_int[4])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_5_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[5]),
    .o_out  (rxprbssel_int[5])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_6_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[6]),
    .o_out  (rxprbssel_int[6])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_7_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[7]),
    .o_out  (rxprbssel_int[7])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_8_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[8]),
    .o_out  (rxprbssel_int[8])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_9_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[9]),
    .o_out  (rxprbssel_int[9])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_10_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[10]),
    .o_out  (rxprbssel_int[10])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_11_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[11]),
    .o_out  (rxprbssel_int[11])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_12_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[12]),
    .o_out  (rxprbssel_int[12])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_13_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[13]),
    .o_out  (rxprbssel_int[13])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_14_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[14]),
    .o_out  (rxprbssel_int[14])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_15_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[15]),
    .o_out  (rxprbssel_int[15])
  );

  // Synchronize txprbsforceerr into the TXUSRCLK2 clock domain from VIO usage
  wire [3:0] txprbsforceerr_vio_async;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbsforceerr_0_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbsforceerr_vio_async[0]),
    .o_out  (txprbsforceerr_int[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbsforceerr_1_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbsforceerr_vio_async[1]),
    .o_out  (txprbsforceerr_int[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbsforceerr_2_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbsforceerr_vio_async[2]),
    .o_out  (txprbsforceerr_int[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_txprbsforceerr_3_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbsforceerr_vio_async[3]),
    .o_out  (txprbsforceerr_int[3])
  );

  // Synchronize rxprbscntreset into the RXUSRCLK2 clock domain from VIO usage
  wire [3:0] rxprbscntreset_vio_async;

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbscntreset_0_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbscntreset_vio_async[0]),
    .o_out  (rxprbscntreset_int[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbscntreset_1_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbscntreset_vio_async[1]),
    .o_out  (rxprbscntreset_int[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbscntreset_2_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbscntreset_vio_async[2]),
    .o_out  (rxprbscntreset_int[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gty_quad_example_bit_synchronizer bit_synchronizer_vio_rxprbscntreset_3_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbscntreset_vio_async[3]),
    .o_out  (rxprbscntreset_int[3])
  );

  // Instantiate the VIO IP core for hardware bring-up and debug purposes, connecting relevant debug and analysis
  // signals which have been enabled during Wizard IP customization. This initial set of connected signals is
  // provided as a convenience and example, but more or fewer ports can be used as needed; simply re-customize and
  // re-generate the VIO instance, then connect any exposed signals that are needed. Signals which are synchronous to
  // clocks other than the free-running clock will require synchronization. For usage, refer to Vivado Design Suite
  // User Guide: Programming and Debugging (UG908)
  gty_quad_vio_0 gty_quad_vio_0_inst (
    .clk (hb_gtwiz_reset_clk_freerun_buf_int)
    ,.probe_in0 (link_status_out)
    ,.probe_in1 (link_down_latched_out)
    ,.probe_in2 (init_done_int)
    ,.probe_in3 (init_retry_ctr_int)
    ,.probe_in4 (gtpowergood_vio_sync)
    ,.probe_in5 (qpll0lock_vio_sync)
    ,.probe_in6 (qpll1lock_vio_sync)
    ,.probe_in7 (cplllock_vio_sync)
    ,.probe_in8 (txpmaresetdone_vio_sync)
    ,.probe_in9 (rxpmaresetdone_vio_sync)
    ,.probe_in10 (gtwiz_reset_tx_done_vio_sync)
    ,.probe_in11 (gtwiz_reset_rx_done_vio_sync)
    ,.probe_in12 (rxbufstatus_vio_sync)
    ,.probe_in13 (rxprbserr_vio_sync)
    ,.probe_out0 (hb_gtwiz_reset_all_vio_int)
    ,.probe_out1 (hb0_gtwiz_reset_tx_pll_and_datapath_int)
    ,.probe_out2 (hb0_gtwiz_reset_tx_datapath_int)
    ,.probe_out3 (hb_gtwiz_reset_rx_pll_and_datapath_vio_int)
    ,.probe_out4 (hb_gtwiz_reset_rx_datapath_vio_int)
    ,.probe_out5 (link_down_latched_reset_vio_int)
    ,.probe_out6 (txpmareset_int)
    ,.probe_out7 (rxpmareset_int)
    ,.probe_out8 (txpcsreset_int)
    ,.probe_out9 (rxpcsreset_int)
    ,.probe_out10 (rxdfelpmreset_int)
    ,.probe_out11 (txprecursor_int)
    ,.probe_out12 (txpostcursor_int)
    ,.probe_out13 (loopback_int)
    ,.probe_out14 (txprbssel_vio_async)
    ,.probe_out15 (rxprbssel_vio_async)
    ,.probe_out16 (txprbsforceerr_vio_async)
    ,.probe_out17 (rxprbscntreset_vio_async)
  );


  // ===================================================================================================================
  // EXAMPLE WRAPPER INSTANCE
  // ===================================================================================================================

  // Instantiate the example design wrapper, mapping its enabled ports to per-channel internal signals and example
  // resources as appropriate
  gty_quad_example_wrapper example_wrapper_inst (
    .gtyrxn_in                               (gtyrxn_int)
   ,.gtyrxp_in                               (gtyrxp_int)
   ,.gtytxn_out                              (gtytxn_int)
   ,.gtytxp_out                              (gtytxp_int)
   ,.gtwiz_userclk_tx_reset_in               (gtwiz_userclk_tx_reset_int)
   ,.gtwiz_userclk_tx_srcclk_out             (gtwiz_userclk_tx_srcclk_int)
   ,.gtwiz_userclk_tx_usrclk_out             (gtwiz_userclk_tx_usrclk_int)
   ,.gtwiz_userclk_tx_usrclk2_out            (gtwiz_userclk_tx_usrclk2_int)
   ,.gtwiz_userclk_tx_active_out             (gtwiz_userclk_tx_active_int)
   ,.gtwiz_userclk_rx_reset_in               (gtwiz_userclk_rx_reset_int)
   ,.gtwiz_userclk_rx_srcclk_out             (gtwiz_userclk_rx_srcclk_int)
   ,.gtwiz_userclk_rx_usrclk_out             (gtwiz_userclk_rx_usrclk_int)
   ,.gtwiz_userclk_rx_usrclk2_out            (gtwiz_userclk_rx_usrclk2_int)
   ,.gtwiz_userclk_rx_active_out             (gtwiz_userclk_rx_active_int)
   ,.gtwiz_reset_clk_freerun_in              ({1{hb_gtwiz_reset_clk_freerun_buf_int}})
   ,.gtwiz_reset_all_in                      ({1{hb_gtwiz_reset_all_int}})
   ,.gtwiz_reset_tx_pll_and_datapath_in      (gtwiz_reset_tx_pll_and_datapath_int)
   ,.gtwiz_reset_tx_datapath_in              (gtwiz_reset_tx_datapath_int)
   ,.gtwiz_reset_rx_pll_and_datapath_in      ({1{hb_gtwiz_reset_rx_pll_and_datapath_int}})
   ,.gtwiz_reset_rx_datapath_in              ({1{hb_gtwiz_reset_rx_datapath_int}})
   ,.gtwiz_reset_rx_cdr_stable_out           (gtwiz_reset_rx_cdr_stable_int)
   ,.gtwiz_reset_tx_done_out                 (gtwiz_reset_tx_done_int)
   ,.gtwiz_reset_rx_done_out                 (gtwiz_reset_rx_done_int)
   ,.gtwiz_userdata_tx_in                    (gtwiz_userdata_tx_int)
   ,.gtwiz_userdata_rx_out                   (gtwiz_userdata_rx_int)
   ,.drpaddr_common_in                       (drpaddr_common_int)
   ,.drpclk_common_in                        (drpclk_common_int)
   ,.drpdi_common_in                         (drpdi_common_int)
   ,.drpen_common_in                         (drpen_common_int)
   ,.drpwe_common_in                         (drpwe_common_int)
   ,.gtrefclk00_in                           (gtrefclk00_int)
   ,.drpdo_common_out                        (drpdo_common_int)
   ,.drprdy_common_out                       (drprdy_common_int)
   ,.qpll0lock_out                           (qpll0lock_int)
   ,.qpll0outclk_out                         (qpll0outclk_int)
   ,.qpll0outrefclk_out                      (qpll0outrefclk_int)
   ,.qpll1lock_out                           (qpll1lock_int)
   ,.drpaddr_in                              (drpaddr_int)
   ,.drpclk_in                               (drpclk_int)
   ,.drpdi_in                                (drpdi_int)
   ,.drpen_in                                (drpen_int)
   ,.drpwe_in                                (drpwe_int)
   ,.eyescanreset_in                         (eyescanreset_int)
   ,.eyescantrigger_in                       (eyescantrigger_int)
   ,.loopback_in                             (loopback_int)
   ,.pcsrsvdin_in                            (pcsrsvdin_int)
   ,.rxbufreset_in                           (rxbufreset_int)
   ,.rxcdrhold_in                            (rxcdrhold_int)
   ,.rxdfelpmreset_in                        (rxdfelpmreset_int)
   ,.rxlpmen_in                              (rxlpmen_int)
   ,.rxpcsreset_in                           (rxpcsreset_int)
   ,.rxpmareset_in                           (rxpmareset_int)
   ,.rxpolarity_in                           (rxpolarity_int)
   ,.rxprbscntreset_in                       (rxprbscntreset_int)
   ,.rxprbssel_in                            (rxprbssel_int)
   ,.rxrate_in                               (rxrate_int)
   ,.txdiffctrl_in                           (txdiffctrl_int)
   ,.txinhibit_in                            (txinhibit_int)
   ,.txpcsreset_in                           (txpcsreset_int)
   ,.txpmareset_in                           (txpmareset_int)
   ,.txpolarity_in                           (txpolarity_int)
   ,.txpostcursor_in                         (txpostcursor_int)
   ,.txprbsforceerr_in                       (txprbsforceerr_int)
   ,.txprbssel_in                            (txprbssel_int)
   ,.txprecursor_in                          (txprecursor_int)
   ,.cplllock_out                            (cplllock_int)
   ,.dmonitorout_out                         (dmonitorout_int)
   ,.drpdo_out                               (drpdo_int)
   ,.drprdy_out                              (drprdy_int)
   ,.eyescandataerror_out                    (eyescandataerror_int)
   ,.gtpowergood_out                         (gtpowergood_int)
   ,.rxbufstatus_out                         (rxbufstatus_int)
   ,.rxcommadet_out                          (rxcommadet_int)
   ,.rxctrl1_out                             (rxctrl1_int)
   ,.rxctrl3_out                             (rxctrl3_int)
   ,.rxdlysresetdone_out                     (rxdlysresetdone_int)
   ,.rxphaligndone_out                       (rxphaligndone_int)
   ,.rxpmaresetdone_out                      (rxpmaresetdone_int)
   ,.rxprbserr_out                           (rxprbserr_int)
   ,.rxresetdone_out                         (rxresetdone_int)
   ,.rxsyncdone_out                          (rxsyncdone_int)
   ,.txbufstatus_out                         (txbufstatus_int)
   ,.txdlysresetdone_out                     (txdlysresetdone_int)
   ,.txphaligndone_out                       (txphaligndone_int)
   ,.txphinitdone_out                        (txphinitdone_int)
   ,.txpmaresetdone_out                      (txpmaresetdone_int)
   ,.txresetdone_out                         (txresetdone_int)
);


endmodule

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
module gty_64_156_10G_top (

  input  wire [9:0] drpaddr_vio_int,
//  input  wire [0:0] drpclk_vio_int,
  input  wire [15:0] drpdi_vio_int,
  input  wire [0:0] drpen_vio_int,
  input  wire [0:0] drpwe_vio_int,
  output  wire [15:0] drpdo_vio_int,
  output  wire [0:0] drprdy_vio_int,
  input  wire [9:0] drpaddr_common_int,
//  input  wire [0:0] drpclk_common_int,
  input  wire [15:0] drpdi_common_int,
  input  wire [0:0] drpen_common_int,
  input  wire [0:0] drpwe_common_int,
  output  wire [15:0] drpdo_common_int,
  output  wire [0:0] drprdy_common_int,
  input  wire [9:0] drpaddr_int,
//  input  wire [0:0] drpclk_int,
  input  wire [15:0] drpdi_int,
  input  wire [0:0] drpen_int,
  input  wire [0:0] drpwe_int,
  output  wire [15:0] drpdo_int,
  output  wire [0:0] drprdy_int,


  // Differential reference clock inputs
  input  wire mgtrefclk1_x0y2_p,
  input  wire mgtrefclk1_x0y2_n,

  // Serial data ports for transceiver channel 0
  input  wire ch0_gtyrxn_in,
  input  wire ch0_gtyrxp_in,
  output wire ch0_gtytxn_out,
  output wire ch0_gtytxp_out,

  // User-provided ports for reset helper block(s)
  input  wire hb_gtwiz_reset_clk_freerun_in,
  input  wire hb_gtwiz_reset_all_in,

  // PRBS-based link status ports
  input  wire link_down_latched_reset_in,
  output wire link_status_out,
  output reg  link_down_latched_out = 1'b1

);
   wire [2:0] rxoutclksel_int;
   //wire [2:0] ch0_rxoutclksel_int = 3'b010;
   //assign rxoutclksel_int[2:0] = ch0_rxoutclksel_int;
   wire [2:0] txoutclksel_int;
   //wire [2:0] ch0_txoutclksel_int = 3'b010;
   //assign txoutclksel_int[2:0] = ch0_txoutclksel_int;
 
  wire [0:0] drpclk_common_int;
  wire [0:0] drpclk_int;
  assign drpclk_int[0:0] = hb_gtwiz_reset_clk_freerun_in;
  assign drpclk_common_int[0:0] = hb_gtwiz_reset_clk_freerun_in;

wire [63:0]          rd_data;
wire                 rd_data_v;
assign drpdo_vio_int    = {16{rd_data_v}} & rd_data[15:0];
assign drprdy_vio_int   = rd_data_v;


  wire [0:0] rxprbslocked_int;
  wire [0:0] ch0_rxprbslocked_int;
  assign ch0_rxprbslocked_int = rxprbslocked_int[0:0];

  wire hb_gtwiz_reset_clk_freerun_buf_int;
  //--------------------------------------------------------------------------------------------------------------------
  // Synchronize rxprbslocked into the free-running clock domain for VIO usage
  wire [0:0] rxprbslocked_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxprbslocked_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxprbslocked_int[0]),
    .o_out  (rxprbslocked_vio_sync[0])
  );


//  wire [15:0] drpaddr_common_int;
//  wire [15:0] cm0_drpaddr_common_int = 16'b0000000000000000;
//  assign drpaddr_common_int[15:0] = cm0_drpaddr_common_int;
//  wire [0:0] drpclk_common_int;
//  wire [0:0] cm0_drpclk_common_int = 1'b0;
//  assign drpclk_common_int[0:0] = cm0_drpclk_common_int;
//  wire [15:0] drpdi_common_int;
//  wire [15:0] cm0_drpdi_common_int = 16'b0000000000000000;
//  assign drpdi_common_int[15:0] = cm0_drpdi_common_int;
//  wire [0:0] drpen_common_int;
//  wire [0:0] cm0_drpen_common_int = 1'b0;
//  assign drpen_common_int[0:0] = cm0_drpen_common_int;
//  wire [0:0] drpwe_common_int;
//  wire [0:0] cm0_drpwe_common_int = 1'b0;
//  assign drpwe_common_int[0:0] = cm0_drpwe_common_int;
//  wire [15:0] drpdo_common_int;
//  wire [15:0] cm0_drpdo_common_int;
//  assign cm0_drpdo_common_int = drpdo_common_int[15:0];
//  wire [0:0] drprdy_common_int;
//  wire [0:0] cm0_drprdy_common_int;
//  assign cm0_drprdy_common_int = drprdy_common_int[0:0];
//  wire [9:0] drpaddr_int;
//  wire [9:0] ch0_drpaddr_int = 10'b0000000000;
//  assign drpaddr_int[9:0] = ch0_drpaddr_int;
//  wire [0:0] drpclk_int;
//  wire [0:0] ch0_drpclk_int = 1'b0;
//  assign drpclk_int[0:0] = ch0_drpclk_int;
//  wire [15:0] drpdi_int;
//  wire [15:0] ch0_drpdi_int = 16'b0000000000000000;
//  assign drpdi_int[15:0] = ch0_drpdi_int;
//  wire [0:0] drpen_int;
//  wire [0:0] ch0_drpen_int = 1'b0;
//  assign drpen_int[0:0] = ch0_drpen_int;
//  wire [0:0] drpwe_int;
//  wire [0:0] ch0_drpwe_int = 1'b0;
//  assign drpwe_int[0:0] = ch0_drpwe_int;
//  wire [15:0] drpdo_int;
//  wire [15:0] ch0_drpdo_int;
//  assign ch0_drpdo_int = drpdo_int[15:0];
//  wire [0:0] drprdy_int;
//  wire [0:0] ch0_drprdy_int;
//  assign ch0_drprdy_int = drprdy_int[0:0];



  // ===================================================================================================================
  // PER-CHANNEL SIGNAL ASSIGNMENTS
  // ===================================================================================================================

  // The core and example design wrapper vectorize ports across all enabled transceiver channel and common instances for
  // simplicity and compactness. This example design top module assigns slices of each vector to individual, per-channel
  // signal vectors for use if desired. Signals which connect to helper blocks are prefixed "hb#", signals which connect
  // to transceiver common primitives are prefixed "cm#", and signals which connect to transceiver channel primitives
  // are prefixed "ch#", where "#" is the sequential resource number.

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtyrxn_int;
  assign gtyrxn_int[0:0] = ch0_gtyrxn_in;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtyrxp_int;
  assign gtyrxp_int[0:0] = ch0_gtyrxp_in;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtytxn_int;
  assign ch0_gtytxn_out = gtytxn_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtytxp_int;
  assign ch0_gtytxp_out = gtytxp_int[0:0];

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
  // assign hb0_gtwiz_reset_rx_cdr_stable_int = gtwiz_reset_rx_cdr_stable_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_done_int;
  wire [0:0] hb0_gtwiz_reset_tx_done_int;
  assign hb0_gtwiz_reset_tx_done_int = gtwiz_reset_tx_done_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_done_int;
  wire [0:0] hb0_gtwiz_reset_rx_done_int;
  assign hb0_gtwiz_reset_rx_done_int = gtwiz_reset_rx_done_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] gtwiz_userdata_tx_int;
  wire [63:0] hb0_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[63:0] = hb0_gtwiz_userdata_tx_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] gtwiz_userdata_rx_int;
  wire [63:0] hb0_gtwiz_userdata_rx_int;
  assign hb0_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[63:0];

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtrefclk01_int;
  wire [0:0] cm0_gtrefclk01_int;
  assign gtrefclk01_int[0:0] = cm0_gtrefclk01_int;


  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll0lock_int;
  wire [0:0] cm0_qpll0lock_int;
  assign cm0_qpll0lock_int = qpll0lock_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll1lock_int;
  wire [0:0] cm0_qpll1lock_int;
  assign cm0_qpll1lock_int = qpll1lock_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll1outclk_int;
  wire [0:0] cm0_qpll1outclk_int;
  assign cm0_qpll1outclk_int = qpll1outclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll1outrefclk_int;
  wire [0:0] cm0_qpll1outrefclk_int;
  assign cm0_qpll1outrefclk_int = qpll1outrefclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] eyescanreset_int;
  wire [0:0] ch0_eyescanreset_int = 1'b0;
  // assign eyescanreset_int[0:0] = ch0_eyescanreset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] eyescantrigger_int;
  wire [0:0] ch0_eyescantrigger_int = 1'b0;
  // assign eyescantrigger_int[0:0] = ch0_eyescantrigger_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [2:0] loopback_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [15:0] pcsrsvdin_int;
  wire [15:0] ch0_pcsrsvdin_int = 16'b0000000000000000;
  // assign pcsrsvdin_int[15:0] = ch0_pcsrsvdin_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxbufreset_int;
  wire [0:0] ch0_rxbufreset_int = 1'b0;
  // assign rxbufreset_int[0:0] = ch0_rxbufreset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxcdrhold_int;
  wire [0:0] ch0_rxcdrhold_int = 1'b0;
  // assign rxcdrhold_int[0:0] = ch0_rxcdrhold_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxdfelpmreset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxlpmen_int;
  wire [0:0] ch0_rxlpmen_int = 1'b1;
  // assign rxlpmen_int[0:0] = ch0_rxlpmen_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxpcsreset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxpmareset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxpolarity_int;
  wire [0:0] ch0_rxpolarity_int = 1'b0;
  // assign rxpolarity_int[0:0] = ch0_rxpolarity_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxprbscntreset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxprbssel_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [2:0] rxrate_int;
  wire [2:0] ch0_rxrate_int = 3'b000;
  // assign rxrate_int[2:0] = ch0_rxrate_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [4:0] txdiffctrl_int;
  wire [4:0] ch0_txdiffctrl_int = 5'b11000;
  // assign txdiffctrl_int[4:0] = ch0_txdiffctrl_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txinhibit_int;
  wire [0:0] ch0_txinhibit_int = 1'b0;
  // assign txinhibit_int[0:0] = ch0_txinhibit_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txpcsreset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txpmareset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txpolarity_int;
  wire [0:0] ch0_txpolarity_int = 1'b0;
  // assign txpolarity_int[0:0] = ch0_txpolarity_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [4:0] txpostcursor_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txprbsforceerr_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txprbssel_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [4:0] txprecursor_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] cplllock_int;
  wire [0:0] ch0_cplllock_int;
  assign ch0_cplllock_int = cplllock_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [15:0] dmonitorout_int;
  wire [15:0] ch0_dmonitorout_int;
  // assign ch0_dmonitorout_int = dmonitorout_int[15:0];

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] eyescandataerror_int;
  wire [0:0] ch0_eyescandataerror_int;
  // assign ch0_eyescandataerror_int = eyescandataerror_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtpowergood_int;
  wire [0:0] ch0_gtpowergood_int;
  assign ch0_gtpowergood_int = gtpowergood_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [2:0] rxbufstatus_int;
  wire [2:0] ch0_rxbufstatus_int;
  assign ch0_rxbufstatus_int = rxbufstatus_int[2:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxcommadet_int;
  wire [0:0] ch0_rxcommadet_int;
  // assign ch0_rxcommadet_int = rxcommadet_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [15:0] rxctrl1_int;
  wire [15:0] ch0_rxctrl1_int;
  // assign ch0_rxctrl1_int = rxctrl1_int[15:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [7:0] rxctrl3_int;
  wire [7:0] ch0_rxctrl3_int;
  // assign ch0_rxctrl3_int = rxctrl3_int[7:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxdlysresetdone_int;
  wire [0:0] ch0_rxdlysresetdone_int;
  // assign ch0_rxdlysresetdone_int = rxdlysresetdone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxphaligndone_int;
  wire [0:0] ch0_rxphaligndone_int;
  // assign ch0_rxphaligndone_int = rxphaligndone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxpmaresetdone_int;
  wire [0:0] ch0_rxpmaresetdone_int;
  assign ch0_rxpmaresetdone_int = rxpmaresetdone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxprbserr_int;
  wire [0:0] ch0_rxprbserr_int;
  assign ch0_rxprbserr_int = rxprbserr_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxresetdone_int;
  wire [0:0] ch0_rxresetdone_int;
  // assign ch0_rxresetdone_int = rxresetdone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] rxsyncdone_int;
  wire [0:0] ch0_rxsyncdone_int;
  // assign ch0_rxsyncdone_int = rxsyncdone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [1:0] txbufstatus_int;
  wire [1:0] ch0_txbufstatus_int;
  // assign ch0_txbufstatus_int = txbufstatus_int[1:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txdlysresetdone_int;
  wire [0:0] ch0_txdlysresetdone_int;
  // assign ch0_txdlysresetdone_int = txdlysresetdone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txphaligndone_int;
  wire [0:0] ch0_txphaligndone_int;
  // assign ch0_txphaligndone_int = txphaligndone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txphinitdone_int;
  wire [0:0] ch0_txphinitdone_int;
  // assign ch0_txphinitdone_int = txphinitdone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txpmaresetdone_int;
  wire [0:0] ch0_txpmaresetdone_int;
  assign ch0_txpmaresetdone_int = txpmaresetdone_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] txresetdone_int;
  wire [0:0] ch0_txresetdone_int;
  // assign ch0_txresetdone_int = txresetdone_int[0:0];


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

  BUFG bufg_clk_freerun_inst (
    .I (hb_gtwiz_reset_clk_freerun_in),
    .O (hb_gtwiz_reset_clk_freerun_buf_int)
  );

  // Instantiate a differential reference clock buffer for each reference clock differential pair in this configuration,
  // and assign the single-ended output of each differential reference clock buffer to the appropriate PLL input signal

  // Differential reference clock buffer for MGTREFCLK1_X0Y2
  wire mgtrefclk1_x0y2_int;

  IBUFDS_GTE4 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE4_MGTREFCLK1_X0Y2_INST (
    .I     (mgtrefclk1_x0y2_p),
    .IB    (mgtrefclk1_x0y2_n),
    .CEB   (1'b0),
    .O     (mgtrefclk1_x0y2_int),
    .ODIV2 ()
  );

  assign cm0_gtrefclk01_int = mgtrefclk1_x0y2_int;


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
  gty_64_156_10G_example_stimulus_raw example_stimulus_inst0 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txdata_out                  (hb0_gtwiz_userdata_tx_int)
  );

  // PRBS checking
  // -------------------------------------------------------------------------------------------------------------------

  // Declare a signal vector of PRBS match indicators, with one indicator bit per transceiver channel
  wire [0:0] prbs_match_int;

  // PRBS-based data checking module for transceiver channel 0
  gty_64_156_10G_example_checking_raw example_checking_inst0 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxdata_in                   (hb0_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[0])
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
  gty_64_156_10G_example_reset_synchronizer reset_synchronizer_prbs_match_all_inst (
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
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_link_down_latched_reset_inst (
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
  gty_64_156_10G_example_init example_init_inst (
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
  wire [0:0] gtpowergood_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_gtpowergood_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtpowergood_int[0]),
    .o_out  (gtpowergood_vio_sync[0])
  );

  // Synchronize qpll0lock into the free-running clock domain for VIO usage
  wire [0:0] qpll0lock_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_qpll0lock_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (qpll0lock_int[0]),
    .o_out  (qpll0lock_vio_sync[0])
  );

  // Synchronize qpll1lock into the free-running clock domain for VIO usage
  wire [0:0] qpll1lock_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_qpll1lock_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (qpll1lock_int[0]),
    .o_out  (qpll1lock_vio_sync[0])
  );

  // Synchronize cplllock into the free-running clock domain for VIO usage
  wire [0:0] cplllock_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_cplllock_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (cplllock_int[0]),
    .o_out  (cplllock_vio_sync[0])
  );

  // Synchronize txpmaresetdone into the free-running clock domain for VIO usage
  wire [0:0] txpmaresetdone_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[0]),
    .o_out  (txpmaresetdone_vio_sync[0])
  );

  // Synchronize rxpmaresetdone into the free-running clock domain for VIO usage
  wire [0:0] rxpmaresetdone_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[0]),
    .o_out  (rxpmaresetdone_vio_sync[0])
  );

  // Synchronize gtwiz_reset_tx_done into the free-running clock domain for VIO usage
  wire [0:0] gtwiz_reset_tx_done_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_gtwiz_reset_tx_done_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtwiz_reset_tx_done_int[0]),
    .o_out  (gtwiz_reset_tx_done_vio_sync[0])
  );

  // Synchronize gtwiz_reset_rx_done into the free-running clock domain for VIO usage
  wire [0:0] gtwiz_reset_rx_done_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_gtwiz_reset_rx_done_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtwiz_reset_rx_done_int[0]),
    .o_out  (gtwiz_reset_rx_done_vio_sync[0])
  );

  // Synchronize rxbufstatus into the free-running clock domain for VIO usage
  wire [2:0] rxbufstatus_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[0]),
    .o_out  (rxbufstatus_vio_sync[0])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[1]),
    .o_out  (rxbufstatus_vio_sync[1])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxbufstatus_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxbufstatus_int[2]),
    .o_out  (rxbufstatus_vio_sync[2])
  );

  // Synchronize rxprbserr into the free-running clock domain for VIO usage
  wire [0:0] rxprbserr_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxprbserr_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxprbserr_int[0]),
    .o_out  (rxprbserr_vio_sync[0])
  );

  // Synchronize txprbssel into the TXUSRCLK2 clock domain from VIO usage
  wire [3:0] txprbssel_vio_async;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_txprbssel_0_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[0]),
    .o_out  (txprbssel_int[0])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_txprbssel_1_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[1]),
    .o_out  (txprbssel_int[1])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_txprbssel_2_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[2]),
    .o_out  (txprbssel_int[2])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_txprbssel_3_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbssel_vio_async[3]),
    .o_out  (txprbssel_int[3])
  );

  // Synchronize rxprbssel into the RXUSRCLK2 clock domain from VIO usage
  wire [3:0] rxprbssel_vio_async;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_0_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[0]),
    .o_out  (rxprbssel_int[0])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_1_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[1]),
    .o_out  (rxprbssel_int[1])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_2_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[2]),
    .o_out  (rxprbssel_int[2])
  );
  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxprbssel_3_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbssel_vio_async[3]),
    .o_out  (rxprbssel_int[3])
  );

  // Synchronize txprbsforceerr into the TXUSRCLK2 clock domain from VIO usage
  wire [0:0] txprbsforceerr_vio_async;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_txprbsforceerr_0_inst (
    .clk_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .i_in   (txprbsforceerr_vio_async[0]),
    .o_out  (txprbsforceerr_int[0])
  );

  // Synchronize rxprbscntreset into the RXUSRCLK2 clock domain from VIO usage
  wire [0:0] rxprbscntreset_vio_async;

  (* DONT_TOUCH = "TRUE" *)
  gty_64_156_10G_example_bit_synchronizer bit_synchronizer_vio_rxprbscntreset_0_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxprbscntreset_vio_async[0]),
    .o_out  (rxprbscntreset_int[0])
  );

  // Instantiate the VIO IP core for hardware bring-up and debug purposes, connecting relevant debug and analysis
  // signals which have been enabled during Wizard IP customization. This initial set of connected signals is
  // provided as a convenience and example, but more or fewer ports can be used as needed; simply re-customize and
  // re-generate the VIO instance, then connect any exposed signals that are needed. Signals which are synchronous to
  // clocks other than the free-running clock will require synchronization. For usage, refer to Vivado Design Suite
  // User Guide: Programming and Debugging (UG908)
//  gty_64_156_10G_vio_0 gty_64_156_10G_vio_0_inst (
//    .clk (hb_gtwiz_reset_clk_freerun_buf_int)
//    ,.probe_in0 (link_status_out)
//    ,.probe_in1 (link_down_latched_out)
//    ,.probe_in2 (init_done_int)
//    ,.probe_in3 (init_retry_ctr_int)
//    ,.probe_in4 (gtpowergood_vio_sync)
//    ,.probe_in5 (qpll0lock_vio_sync)
//    ,.probe_in6 (qpll1lock_vio_sync)
//    ,.probe_in7 (cplllock_vio_sync)
//    ,.probe_in8 (txpmaresetdone_vio_sync)
//    ,.probe_in9 (rxpmaresetdone_vio_sync)
//    ,.probe_in10 (gtwiz_reset_tx_done_vio_sync)
//    ,.probe_in11 (gtwiz_reset_rx_done_vio_sync)
//    ,.probe_in12 (rxbufstatus_vio_sync)
//    ,.probe_in13 (rxprbserr_vio_sync)
//    ,.probe_out0 (hb_gtwiz_reset_all_vio_int)
//    ,.probe_out1 (hb0_gtwiz_reset_tx_pll_and_datapath_int)
//    ,.probe_out2 (hb0_gtwiz_reset_tx_datapath_int)
//    ,.probe_out3 (hb_gtwiz_reset_rx_pll_and_datapath_vio_int)
//    ,.probe_out4 (hb_gtwiz_reset_rx_datapath_vio_int)
//    ,.probe_out5 (link_down_latched_reset_vio_int)
//    ,.probe_out6 (txpmareset_int)
//    ,.probe_out7 (rxpmareset_int)
//    ,.probe_out8 (txpcsreset_int)
//    ,.probe_out9 (rxpcsreset_int)
//    ,.probe_out10 (rxdfelpmreset_int)
//    ,.probe_out11 (txprecursor_int)
//    ,.probe_out12 (txpostcursor_int)
//    ,.probe_out13 (loopback_int)
//    ,.probe_out14 (txprbssel_vio_async)
//    ,.probe_out15 (rxprbssel_vio_async)
//    ,.probe_out16 (txprbsforceerr_vio_async)
//    ,.probe_out17 (rxprbscntreset_vio_async)
//  );
wire                   clk;
wire                   rst_n;
//assign                 clk = hb_gtwiz_reset_clk_freerun_buf_int;
assign                 clk = hb_gtwiz_reset_clk_freerun_in;
assign                 rst_n= !hb_gtwiz_reset_all_in;
wire                   wr_en;
wire                   rd_en;
wire   [9:0]           addr;
wire   [63:0]          wr_data;
assign addr = drpaddr_vio_int[9:0];
assign wr_data = { 48'b0, drpdi_vio_int };
assign wr_en = drpen_vio_int && drpwe_vio_int;
assign rd_en = drpen_vio_int && !drpwe_vio_int;
vio_regs #(
  . LITE                                               ( 0                                                  )
) vio_regs_inst (
  . rd_data                                            ( rd_data                                            ), // output [63:0]
  . rd_data_v                                          ( rd_data_v                                          ), // output
  . oREG_RESET_ALL                                     ( hb_gtwiz_reset_all_vio_int                         ), // output
  . oREG_RESET_TX_PLL_AND_DATAPATH                     ( hb0_gtwiz_reset_tx_pll_and_datapath_int            ), // output
  . oREG_RESET_TX_DATAPATH                             ( hb0_gtwiz_reset_tx_datapath_int                    ), // output
  . oREG_RESET_RX_PLL_AND_DATAPATH                     ( hb_gtwiz_reset_rx_pll_and_datapath_vio_int         ), // output
  . oREG_RESET_RX_DATAPATH                             ( hb_gtwiz_reset_rx_datapath_vio_int                 ), // output
  . oREG_LINK_DOWN_LATCHED_RESET                       ( link_down_latched_reset_vio_int                    ), // output
  . oREG_TXPMARESET                                    ( txpmareset_int                                     ), // output
  . oREG_RXPMARESET                                    ( rxpmareset_int                                     ), // output
  . oREG_TXPCSRESET                                    ( txpcsreset_int                                     ), // output
  . oREG_RXPCSRESET                                    ( rxpcsreset_int                                     ), // output
  . oREG_RXDFELPMRESET                                 ( rxdfelpmreset_int                                  ), // output
  . oREG_TXPRECURSOR                                   ( txprecursor_int                                    ), // output [4:0]
  . oREG_TXPOSTCURSOR                                  ( txpostcursor_int                                   ), // output [4:0]
  . oREG_LOOPBACK                                      ( loopback_int                                       ), // output [2:0]
  . oREG_TXPRBSSEL                                     ( txprbssel_vio_async                                ), // output [3:0]
  . oREG_RXPRBSSEL                                     ( rxprbssel_vio_async                                ), // output [3:0]
  . oREG_TXPRBSFORCEERR                                ( txprbsforceerr_vio_async                           ), // output
  . oREG_RXPRBSCNTRESET                                ( rxprbscntreset_vio_async                           ), // output
  . oREG_EYESCANRESET                                  ( eyescanreset_int                                   ), // output
  . oREG_EYESCANTRIGGER                                ( eyescantrigger_int                                 ), // output
  . oREG_PCSRSVDIN                                     ( pcsrsvdin_int                                      ), // output [15:0]
  . oREG_RXBUFRESET                                    ( rxbufreset_int                                     ), // output
  . oREG_RXCDRHOLD                                     ( rxcdrhold_int                                      ), // output
  . oREG_RXLPMEN                                       ( rxlpmen_int                                        ), // output
  . oREG_RXOUTCLKSEL                                   ( rxoutclksel_int                                    ), // output [2:0]
  . oREG_RXPOLARITY                                    ( rxpolarity_int                                     ), // output
  . oREG_RXRATE                                        ( rxrate_int                                         ), // output [2:0]
  . oREG_TXDIFFCTRL                                    ( txdiffctrl_int                                     ), // output [4:0]
  . oREG_TXINHIBIT                                     ( txinhibit_int                                      ), // output
  . oREG_TXOUTCLKSEL                                   ( txoutclksel_int                                    ), // output [2:0]
  . oREG_TXPOLARITY                                    ( txpolarity_int                                     ), // output
  . clk                                                ( clk                                                ), // input
  . rst_n                                              ( rst_n                                              ), // input
  . wr_en                                              ( wr_en                                              ), // input
  . rd_en                                              ( rd_en                                              ), // input
  . addr                                               ( addr                                               ), // input [9:0]
  . wr_data                                            ( wr_data                                            ), // input [63:0]
  . iREG_LINK_STATUS_OUT                               ( link_status_out                                    ), // input
  . iREG_LINK_DOWN                                     ( link_down_latched_out                              ), // input
  . iREG_INIT_DONE                                     ( init_done_int                                      ), // input
  . iREG_INIT_RETRY_CTR                                ( init_retry_ctr_int                                 ), // input [3:0]
  . iREG_GTPOWERGOOD                                   ( gtpowergood_vio_sync                               ), // input
  . iREG_QPLL0LOCK                                     ( qpll0lock_vio_sync                                 ), // input
  . iREG_QPLL1LOCK                                     ( qpll1lock_vio_sync                                 ), // input
  . iREG_CPLLLOCK                                      ( cplllock_vio_sync                                  ), // input
  . iREG_TXPMARESETDONE                                ( txpmaresetdone_vio_sync                            ), // input
  . iREG_RXPMARESETDONE                                ( rxpmaresetdone_vio_sync                            ), // input
  . iREG_RESET_TX_DONE                                 ( gtwiz_reset_tx_done_vio_sync                       ), // input
  . iREG_RESET_RX_DONE                                 ( gtwiz_reset_rx_done_vio_sync                       ), // input
  . iREG_RXBUFSTATUS                                   ( rxbufstatus_vio_sync                               ), // input [2:0]
  . iREG_RXPRBSERR                                     ( rxprbserr_vio_sync                                 ), // input
  . iREG_RXPRBSLOCKED                                  ( rxprbslocked_vio_sync                              ), // input
  . iREG_RESET_RX_CDR_STABLE                           ( gtwiz_reset_rx_cdr_stable_int                      ), // input
  . iREG_DMONITOROUT                                   ( dmonitorout_int                                    ), // input [15:0]
  . iREG_EYESCANDATAERROR                              ( eyescandataerror_int                               ), // input
  . iREG_RXCOMMADET                                    ( rxcommadet_int                                     ), // input
  . iREG_RXCTRL1                                       ( rxctrl1_int                                        ), // input [15:0]
  . iREG_RXCTRL3                                       ( rxctrl3_int                                        ), // input [7:0]
  . iREG_RXDLYSRESETDONE                               ( rxdlysresetdone_int                                ), // input
  . iREG_RXPHALIGNDONE                                 ( rxphaligndone_int                                  ), // input
  . iREG_RXRESETDONE                                   ( rxresetdone_int                                    ), // input
  . iREG_RXSYNCDONE                                    ( rxsyncdone_int                                     ), // input
  . iREG_TXBUFSTATUS                                   ( txbufstatus_int                                    ), // input [1:0]
  . iREG_TXDLYSRESETDONE                               ( txdlysresetdone_int                                ), // input
  . iREG_TXPHALIGNDONE                                 ( txphaligndone_int                                  ), // input
  . iREG_TXPHINITDONE                                  ( txphinitdone_int                                   ), // input
  . iREG_TXRESETDONE                                   ( txresetdone_int                                    )  // input
);

  // ===================================================================================================================
  // EXAMPLE WRAPPER INSTANCE
  // ===================================================================================================================

  // Instantiate the example design wrapper, mapping its enabled ports to per-channel internal signals and example
  // resources as appropriate
  gty_64_156_10G_example_wrapper example_wrapper_inst (
    .drpaddr_common_in                       ({6'b0,drpaddr_common_int})
   ,.drpclk_common_in                        (drpclk_common_int)
   ,.drpdi_common_in                         (drpdi_common_int)
   ,.drpen_common_in                         (drpen_common_int)
   ,.drpwe_common_in                         (drpwe_common_int)
   ,.drpdo_common_out                        (drpdo_common_int)
   ,.drprdy_common_out                       (drprdy_common_int)
   ,.drpaddr_in                              (drpaddr_int)
   ,.drpclk_in                               (drpclk_int)
   ,.drpdi_in                                (drpdi_int)
   ,.drpen_in                                (drpen_int)
   ,.drpwe_in                                (drpwe_int)
   ,.drpdo_out                               (drpdo_int)
   ,.drprdy_out                              (drprdy_int)

   ,.gtyrxn_in                               (gtyrxn_int)
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
   ,.gtrefclk01_in                           (gtrefclk01_int)
   ,.qpll0lock_out                           (qpll0lock_int)
   ,.qpll1outclk_out                         (qpll1outclk_int)
   ,.qpll1outrefclk_out                      (qpll1outrefclk_int)
   ,.qpll1lock_out                           (qpll1lock_int)
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
   ,.txoutclksel_in                          (txoutclksel_int)
   ,.rxprbslocked_out                        (rxprbslocked_int)
   ,.rxoutclksel_in                          (rxoutclksel_int)
);


endmodule

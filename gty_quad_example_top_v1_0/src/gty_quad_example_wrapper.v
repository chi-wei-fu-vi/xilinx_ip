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
// This example design wrapper module instantiates the core and any helper blocks which the user chose to exclude from
// the core, connects them as appropriate, and maps enabled ports
// =====================================================================================================================

module gty_quad_example_wrapper (
  input  wire [3:0] gtyrxn_in
 ,input  wire [3:0] gtyrxp_in
 ,output wire [3:0] gtytxn_out
 ,output wire [3:0] gtytxp_out
 ,input  wire [0:0] gtwiz_userclk_tx_reset_in
 ,output wire [0:0] gtwiz_userclk_tx_srcclk_out
 ,output wire [0:0] gtwiz_userclk_tx_usrclk_out
 ,output wire [0:0] gtwiz_userclk_tx_usrclk2_out
 ,output wire [0:0] gtwiz_userclk_tx_active_out
 ,input  wire [0:0] gtwiz_userclk_rx_reset_in
 ,output wire [0:0] gtwiz_userclk_rx_srcclk_out
 ,output wire [0:0] gtwiz_userclk_rx_usrclk_out
 ,output wire [0:0] gtwiz_userclk_rx_usrclk2_out
 ,output wire [0:0] gtwiz_userclk_rx_active_out
 ,input  wire [0:0] gtwiz_reset_clk_freerun_in
 ,input  wire [0:0] gtwiz_reset_all_in
 ,input  wire [0:0] gtwiz_reset_tx_pll_and_datapath_in
 ,input  wire [0:0] gtwiz_reset_tx_datapath_in
 ,input  wire [0:0] gtwiz_reset_rx_pll_and_datapath_in
 ,input  wire [0:0] gtwiz_reset_rx_datapath_in
 ,output wire [0:0] gtwiz_reset_rx_cdr_stable_out
 ,output wire [0:0] gtwiz_reset_tx_done_out
 ,output wire [0:0] gtwiz_reset_rx_done_out
 ,input  wire [319:0] gtwiz_userdata_tx_in
 ,output wire [319:0] gtwiz_userdata_rx_out
 ,input  wire [15:0] drpaddr_common_in
 ,input  wire [0:0] drpclk_common_in
 ,input  wire [15:0] drpdi_common_in
 ,input  wire [0:0] drpen_common_in
 ,input  wire [0:0] drpwe_common_in
 ,input  wire [0:0] gtrefclk00_in
 ,output wire [15:0] drpdo_common_out
 ,output wire [0:0] drprdy_common_out
 ,output wire [0:0] qpll0lock_out
 ,output wire [0:0] qpll0outclk_out
 ,output wire [0:0] qpll0outrefclk_out
 ,output wire [0:0] qpll1lock_out
 ,input  wire [39:0] drpaddr_in
 ,input  wire [3:0] drpclk_in
 ,input  wire [63:0] drpdi_in
 ,input  wire [3:0] drpen_in
 ,input  wire [3:0] drpwe_in
 ,input  wire [3:0] eyescanreset_in
 ,input  wire [3:0] eyescantrigger_in
 ,input  wire [11:0] loopback_in
 ,input  wire [63:0] pcsrsvdin_in
 ,input  wire [3:0] rxbufreset_in
 ,input  wire [3:0] rxcdrhold_in
 ,input  wire [3:0] rxdfelpmreset_in
 ,input  wire [3:0] rxlpmen_in
 ,input  wire [3:0] rxpcsreset_in
 ,input  wire [3:0] rxpmareset_in
 ,input  wire [3:0] rxpolarity_in
 ,input  wire [3:0] rxprbscntreset_in
 ,input  wire [15:0] rxprbssel_in
 ,input  wire [11:0] rxrate_in
 ,input  wire [19:0] txdiffctrl_in
 ,input  wire [3:0] txinhibit_in
 ,input  wire [3:0] txpcsreset_in
 ,input  wire [3:0] txpmareset_in
 ,input  wire [3:0] txpolarity_in
 ,input  wire [19:0] txpostcursor_in
 ,input  wire [3:0] txprbsforceerr_in
 ,input  wire [15:0] txprbssel_in
 ,input  wire [19:0] txprecursor_in
 ,output wire [3:0] cplllock_out
 ,output wire [63:0] dmonitorout_out
 ,output wire [63:0] drpdo_out
 ,output wire [3:0] drprdy_out
 ,output wire [3:0] eyescandataerror_out
 ,output wire [3:0] gtpowergood_out
 ,output wire [11:0] rxbufstatus_out
 ,output wire [3:0] rxcommadet_out
 ,output wire [63:0] rxctrl1_out
 ,output wire [31:0] rxctrl3_out
 ,output wire [3:0] rxdlysresetdone_out
 ,output wire [3:0] rxphaligndone_out
 ,output wire [3:0] rxpmaresetdone_out
 ,output wire [3:0] rxprbserr_out
 ,output wire [3:0] rxresetdone_out
 ,output wire [3:0] rxsyncdone_out
 ,output wire [7:0] txbufstatus_out
 ,output wire [3:0] txdlysresetdone_out
 ,output wire [3:0] txphaligndone_out
 ,output wire [3:0] txphinitdone_out
 ,output wire [3:0] txpmaresetdone_out
 ,output wire [3:0] txresetdone_out
);


  // ===================================================================================================================
  // PARAMETERS AND FUNCTIONS
  // ===================================================================================================================

  // Declare and initialize local parameters and functions used for HDL generation
  localparam [191:0] P_CHANNEL_ENABLE = 192'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111100000000;
  `include "gty_quad_example_wrapper_functions.v"
  localparam integer P_TX_MASTER_CH_PACKED_IDX = f_calc_pk_mc_idx(11);
  localparam integer P_RX_MASTER_CH_PACKED_IDX = f_calc_pk_mc_idx(11);


  // ===================================================================================================================
  // HELPER BLOCKS
  // ===================================================================================================================

  // Any helper blocks which the user chose to exclude from the core will appear below. In addition, some signal
  // assignments related to optionally-enabled ports may appear below.

  // -------------------------------------------------------------------------------------------------------------------
  // Transmitter user clocking network helper block
  // -------------------------------------------------------------------------------------------------------------------

  wire [3:0] txusrclk_int;
  wire [3:0] txusrclk2_int;
  wire [3:0] txoutclk_int;

  // Generate a single module instance which is driven by a clock source associated with the master transmitter channel,
  // and which drives TXUSRCLK and TXUSRCLK2 for all channels

  // The source clock is TXOUTCLK from the master transmitter channel
  assign gtwiz_userclk_tx_srcclk_out = txoutclk_int[P_TX_MASTER_CH_PACKED_IDX];

  // Instantiate a single instance of the transmitter user clocking network helper block
  gty_quad_example_gtwiz_userclk_tx gtwiz_userclk_tx_inst (
    .gtwiz_userclk_tx_srcclk_in   (gtwiz_userclk_tx_srcclk_out),
    .gtwiz_userclk_tx_reset_in    (gtwiz_userclk_tx_reset_in),
    .gtwiz_userclk_tx_usrclk_out  (gtwiz_userclk_tx_usrclk_out),
    .gtwiz_userclk_tx_usrclk2_out (gtwiz_userclk_tx_usrclk2_out),
    .gtwiz_userclk_tx_active_out  (gtwiz_userclk_tx_active_out)
  );

  // Drive TXUSRCLK and TXUSRCLK2 for all channels with the respective helper block outputs
  assign txusrclk_int  = {4{gtwiz_userclk_tx_usrclk_out}};
  assign txusrclk2_int = {4{gtwiz_userclk_tx_usrclk2_out}};

  // -------------------------------------------------------------------------------------------------------------------
  // Receiver user clocking network helper block
  // -------------------------------------------------------------------------------------------------------------------

  wire [3:0] rxusrclk_int;
  wire [3:0] rxusrclk2_int;
  wire [3:0] rxoutclk_int;

  // Generate a single module instance which is driven by a clock source associated with the master receiver channel,
  // and which drives RXUSRCLK and RXUSRCLK2 for all channels

  // The source clock is RXOUTCLK from the master receiver channel
  assign gtwiz_userclk_rx_srcclk_out = rxoutclk_int[P_RX_MASTER_CH_PACKED_IDX];

  // Instantiate a single instance of the receiver user clocking network helper block
  gty_quad_example_gtwiz_userclk_rx gtwiz_userclk_rx_inst (
    .gtwiz_userclk_rx_srcclk_in   (gtwiz_userclk_rx_srcclk_out),
    .gtwiz_userclk_rx_reset_in    (gtwiz_userclk_rx_reset_in),
    .gtwiz_userclk_rx_usrclk_out  (gtwiz_userclk_rx_usrclk_out),
    .gtwiz_userclk_rx_usrclk2_out (gtwiz_userclk_rx_usrclk2_out),
    .gtwiz_userclk_rx_active_out  (gtwiz_userclk_rx_active_out)
  );

  // Drive RXUSRCLK and RXUSRCLK2 for all channels with the respective helper block outputs
  assign rxusrclk_int  = {4{gtwiz_userclk_rx_usrclk_out}};
  assign rxusrclk2_int = {4{gtwiz_userclk_rx_usrclk2_out}};
  wire [3:0] txphaligndone_int;

  // Required assignment to expose the TXPHALIGNDONE port per user request
  assign txphaligndone_out = txphaligndone_int;
  wire [3:0] txphinitdone_int;

  // Required assignment to expose the TXPHINITDONE port per user request
  assign txphinitdone_out = txphinitdone_int;
  wire [3:0] txdlysresetdone_int;

  // Required assignment to expose the TXDLYSRESETDONE port per user request
  assign txdlysresetdone_out = txdlysresetdone_int;
  wire [3:0] rxphaligndone_int;

  // Required assignment to expose the RXPHALIGNDONE port per user request
  assign rxphaligndone_out = rxphaligndone_int;
  wire [3:0] rxdlysresetdone_int;

  // Required assignment to expose the RXDLYSRESETDONE port per user request
  assign rxdlysresetdone_out = rxdlysresetdone_int;
  wire [3:0] rxsyncdone_int;

  // Required assignment to expose the RXSYNCDONE port per user request
  assign rxsyncdone_out = rxsyncdone_int;
  wire [3:0] gtpowergood_int;

  // Required assignment to expose the GTPOWERGOOD port per user request
  assign gtpowergood_out = gtpowergood_int;
  wire [3:0] txresetdone_int;

  // Required assignment to expose the TXRESETDONE port per user request
  assign txresetdone_out = txresetdone_int;
  wire [3:0] rxresetdone_int;

  // Required assignment to expose the RXRESETDONE port per user request
  assign rxresetdone_out = rxresetdone_int;
  wire [0:0] qpll0lock_int;

  // Required assignment to expose the QPLL0LOCK port per user request
  assign qpll0lock_out = qpll0lock_int;
  wire [0:0] qpll1lock_int;

  // Required assignment to expose the QPLL1LOCK port per user request
  assign qpll1lock_out = qpll1lock_int;
  wire [3:0] cplllock_int;

  // Required assignment to expose the CPLLLOCK port per user request
  assign cplllock_out = cplllock_int;

  // ----------------------------------------------------------------------------------------------------------------
  // Assignments to expose data ports, or data control ports, per configuration requirement or user request
  // ----------------------------------------------------------------------------------------------------------------

  wire [63:0] rxctrl1_int;

  // Required assignment to expose the RXCTRL1 port per configuration requirement or user request
  assign rxctrl1_out = rxctrl1_int;


  // ===================================================================================================================
  // CORE INSTANCE
  // ===================================================================================================================

  // Instantiate the core, mapping its enabled ports to example design ports and helper blocks as appropriate
  gty_quad gty_quad_inst (
    .gtyrxn_in                               (gtyrxn_in)
   ,.gtyrxp_in                               (gtyrxp_in)
   ,.gtytxn_out                              (gtytxn_out)
   ,.gtytxp_out                              (gtytxp_out)
   ,.gtwiz_userclk_tx_active_in              (gtwiz_userclk_tx_active_out)
   ,.gtwiz_userclk_rx_active_in              (gtwiz_userclk_rx_active_out)
   ,.gtwiz_reset_clk_freerun_in              (gtwiz_reset_clk_freerun_in)
   ,.gtwiz_reset_all_in                      (gtwiz_reset_all_in)
   ,.gtwiz_reset_tx_pll_and_datapath_in      (gtwiz_reset_tx_pll_and_datapath_in)
   ,.gtwiz_reset_tx_datapath_in              (gtwiz_reset_tx_datapath_in)
   ,.gtwiz_reset_rx_pll_and_datapath_in      (gtwiz_reset_rx_pll_and_datapath_in)
   ,.gtwiz_reset_rx_datapath_in              (gtwiz_reset_rx_datapath_in)
   ,.gtwiz_reset_rx_cdr_stable_out           (gtwiz_reset_rx_cdr_stable_out)
   ,.gtwiz_reset_tx_done_out                 (gtwiz_reset_tx_done_out)
   ,.gtwiz_reset_rx_done_out                 (gtwiz_reset_rx_done_out)
   ,.gtwiz_userdata_tx_in                    (gtwiz_userdata_tx_in)
   ,.gtwiz_userdata_rx_out                   (gtwiz_userdata_rx_out)
   ,.drpaddr_common_in                       (drpaddr_common_in)
   ,.drpclk_common_in                        (drpclk_common_in)
   ,.drpdi_common_in                         (drpdi_common_in)
   ,.drpen_common_in                         (drpen_common_in)
   ,.drpwe_common_in                         (drpwe_common_in)
   ,.gtrefclk00_in                           (gtrefclk00_in)
   ,.drpdo_common_out                        (drpdo_common_out)
   ,.drprdy_common_out                       (drprdy_common_out)
   ,.qpll0lock_out                           (qpll0lock_int)
   ,.qpll0outclk_out                         (qpll0outclk_out)
   ,.qpll0outrefclk_out                      (qpll0outrefclk_out)
   ,.qpll1lock_out                           (qpll1lock_int)
   ,.drpaddr_in                              (drpaddr_in)
   ,.drpclk_in                               (drpclk_in)
   ,.drpdi_in                                (drpdi_in)
   ,.drpen_in                                (drpen_in)
   ,.drpwe_in                                (drpwe_in)
   ,.eyescanreset_in                         (eyescanreset_in)
   ,.eyescantrigger_in                       (eyescantrigger_in)
   ,.loopback_in                             (loopback_in)
   ,.pcsrsvdin_in                            (pcsrsvdin_in)
   ,.rxbufreset_in                           (rxbufreset_in)
   ,.rxcdrhold_in                            (rxcdrhold_in)
   ,.rxdfelpmreset_in                        (rxdfelpmreset_in)
   ,.rxlpmen_in                              (rxlpmen_in)
   ,.rxpcsreset_in                           (rxpcsreset_in)
   ,.rxpmareset_in                           (rxpmareset_in)
   ,.rxpolarity_in                           (rxpolarity_in)
   ,.rxprbscntreset_in                       (rxprbscntreset_in)
   ,.rxprbssel_in                            (rxprbssel_in)
   ,.rxrate_in                               (rxrate_in)
   ,.rxusrclk_in                             (rxusrclk_int)
   ,.rxusrclk2_in                            (rxusrclk2_int)
   ,.txdiffctrl_in                           (txdiffctrl_in)
   ,.txinhibit_in                            (txinhibit_in)
   ,.txpcsreset_in                           (txpcsreset_in)
   ,.txpmareset_in                           (txpmareset_in)
   ,.txpolarity_in                           (txpolarity_in)
   ,.txpostcursor_in                         (txpostcursor_in)
   ,.txprbsforceerr_in                       (txprbsforceerr_in)
   ,.txprbssel_in                            (txprbssel_in)
   ,.txprecursor_in                          (txprecursor_in)
   ,.txusrclk_in                             (txusrclk_int)
   ,.txusrclk2_in                            (txusrclk2_int)
   ,.cplllock_out                            (cplllock_int)
   ,.dmonitorout_out                         (dmonitorout_out)
   ,.drpdo_out                               (drpdo_out)
   ,.drprdy_out                              (drprdy_out)
   ,.eyescandataerror_out                    (eyescandataerror_out)
   ,.gtpowergood_out                         (gtpowergood_int)
   ,.rxbufstatus_out                         (rxbufstatus_out)
   ,.rxcommadet_out                          (rxcommadet_out)
   ,.rxctrl1_out                             (rxctrl1_int)
   ,.rxctrl3_out                             (rxctrl3_out)
   ,.rxdlysresetdone_out                     (rxdlysresetdone_int)
   ,.rxoutclk_out                            (rxoutclk_int)
   ,.rxphaligndone_out                       (rxphaligndone_int)
   ,.rxpmaresetdone_out                      (rxpmaresetdone_out)
   ,.rxprbserr_out                           (rxprbserr_out)
   ,.rxresetdone_out                         (rxresetdone_int)
   ,.rxsyncdone_out                          (rxsyncdone_int)
   ,.txbufstatus_out                         (txbufstatus_out)
   ,.txdlysresetdone_out                     (txdlysresetdone_int)
   ,.txoutclk_out                            (txoutclk_int)
   ,.txphaligndone_out                       (txphaligndone_int)
   ,.txphinitdone_out                        (txphinitdone_int)
   ,.txpmaresetdone_out                      (txpmaresetdone_out)
   ,.txresetdone_out                         (txresetdone_int)
);

endmodule

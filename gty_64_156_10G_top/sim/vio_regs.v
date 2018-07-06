/********************************CONFIDENTIAL****************************
* Copyright (c) 2014 Virtual Instruments.
* 25 Metro Dr, STE#400, San Jose, CA 95110
* www.virtualinstruments.com
* $Archive: $
* $Author: $
* $Date: $
* $Revision: $
* Description:
* This module contains configuration registers and counters.
* This was generated from eth_mac/doc/eth_mac_regs.xml and vgen script. Do not manually modify it
* All manual changes will be overwritten by script whenever new file is generated.

***************************************************************************/
module vio_regs #(
  parameter LITE=0
) (
  output logic [63:0]          rd_data,
  output logic                 rd_data_v,
  output logic                 oREG_RESET_ALL,
  output logic                 oREG_RESET_TX_PLL_AND_DATAPATH,
  output logic                 oREG_RESET_TX_DATAPATH,
  output logic                 oREG_RESET_RX_PLL_AND_DATAPATH,
  output logic                 oREG_RESET_RX_DATAPATH,
  output logic                 oREG_LINK_DOWN_LATCHED_RESET,
  output logic                 oREG_TXPMARESET,
  output logic                 oREG_RXPMARESET,
  output logic                 oREG_TXPCSRESET,
  output logic                 oREG_RXPCSRESET,
  output logic                 oREG_RXDFELPMRESET,
  output logic [4:0]           oREG_TXPRECURSOR,
  output logic [4:0]           oREG_TXPOSTCURSOR,
  output logic [2:0]           oREG_LOOPBACK,
  output logic [3:0]           oREG_TXPRBSSEL,
  output logic [3:0]           oREG_RXPRBSSEL,
  output logic                 oREG_TXPRBSFORCEERR,
  output logic                 oREG_RXPRBSCNTRESET,
  output logic                 oREG_EYESCANRESET,
  output logic                 oREG_EYESCANTRIGGER,
  output logic [15:0]          oREG_PCSRSVDIN,
  output logic                 oREG_RXBUFRESET,
  output logic                 oREG_RXCDRHOLD,
  output logic                 oREG_RXLPMEN,
  output logic [2:0]           oREG_RXOUTCLKSEL,
  output logic                 oREG_RXPOLARITY,
  output logic [2:0]           oREG_RXRATE,
  output logic [4:0]           oREG_TXDIFFCTRL,
  output logic                 oREG_TXINHIBIT,
  output logic [2:0]           oREG_TXOUTCLKSEL,
  output logic                 oREG_TXPOLARITY,
  input                        clk,
  input                        rst_n,
  input                        wr_en,
  input                        rd_en,
  input        [9:0]           addr,
  input        [63:0]          wr_data,
  input                        iREG_LINK_STATUS_OUT,
  input                        iREG_LINK_DOWN,
  input                        iREG_INIT_DONE,
  input        [3:0]           iREG_INIT_RETRY_CTR,
  input                        iREG_GTPOWERGOOD,
  input                        iREG_QPLL0LOCK,
  input                        iREG_QPLL1LOCK,
  input                        iREG_CPLLLOCK,
  input                        iREG_TXPMARESETDONE,
  input                        iREG_RXPMARESETDONE,
  input                        iREG_RESET_TX_DONE,
  input                        iREG_RESET_RX_DONE,
  input        [2:0]           iREG_RXBUFSTATUS,
  input                        iREG_RXPRBSERR,
  input                        iREG_RXPRBSLOCKED,
  input                        iREG_RESET_RX_CDR_STABLE,
  input        [15:0]          iREG_DMONITOROUT,
  input                        iREG_EYESCANDATAERROR,
  input                        iREG_RXCOMMADET,
  input        [15:0]          iREG_RXCTRL1,
  input        [7:0]           iREG_RXCTRL3,
  input                        iREG_RXDLYSRESETDONE,
  input                        iREG_RXPHALIGNDONE,
  input                        iREG_RXRESETDONE,
  input                        iREG_RXSYNCDONE,
  input        [1:0]           iREG_TXBUFSTATUS,
  input                        iREG_TXDLYSRESETDONE,
  input                        iREG_TXPHALIGNDONE,
  input                        iREG_TXPHINITDONE,
  input                        iREG_TXRESETDONE
);


  wire                         RESET_ALL_wr_sel;
  wire                         RESET_ALL_rd_sel;
  wire                         RESET_TX_PLL_AND_DATAPATH_wr_sel;
  wire                         RESET_TX_PLL_AND_DATAPATH_rd_sel;
  wire                         RESET_TX_DATAPATH_wr_sel;
  wire                         RESET_TX_DATAPATH_rd_sel;
  wire                         RESET_RX_PLL_AND_DATAPATH_wr_sel;
  wire                         RESET_RX_PLL_AND_DATAPATH_rd_sel;
  wire                         RESET_RX_DATAPATH_wr_sel;
  wire                         RESET_RX_DATAPATH_rd_sel;
  wire                         LINK_DOWN_LATCHED_RESET_wr_sel;
  wire                         LINK_DOWN_LATCHED_RESET_rd_sel;
  wire                         TXPMARESET_wr_sel;
  wire                         TXPMARESET_rd_sel;
  wire                         RXPMARESET_wr_sel;
  wire                         RXPMARESET_rd_sel;
  wire                         TXPCSRESET_wr_sel;
  wire                         TXPCSRESET_rd_sel;
  wire                         RXPCSRESET_wr_sel;
  wire                         RXPCSRESET_rd_sel;
  wire                         RXDFELPMRESET_wr_sel;
  wire                         RXDFELPMRESET_rd_sel;
  wire                         TXPRECURSOR_wr_sel;
  wire                         TXPRECURSOR_rd_sel;
  wire                         TXPOSTCURSOR_wr_sel;
  wire                         TXPOSTCURSOR_rd_sel;
  wire                         LOOPBACK_wr_sel;
  wire                         LOOPBACK_rd_sel;
  wire                         TXPRBSSEL_wr_sel;
  wire                         TXPRBSSEL_rd_sel;
  wire                         RXPRBSSEL_wr_sel;
  wire                         RXPRBSSEL_rd_sel;
  wire                         TXPRBSFORCEERR_wr_sel;
  wire                         TXPRBSFORCEERR_rd_sel;
  wire                         RXPRBSCNTRESET_wr_sel;
  wire                         RXPRBSCNTRESET_rd_sel;
  wire                         LINK_STATUS_OUT_rd_sel;
  wire                         LINK_STATUS_OUT;
  wire                         LINK_DOWN_rd_sel;
  wire                         LINK_DOWN;
  wire                         INIT_DONE_rd_sel;
  wire                         INIT_DONE;
  wire                         INIT_RETRY_CTR_rd_sel;
  wire   [3:0]                 INIT_RETRY_CTR;
  wire                         GTPOWERGOOD_rd_sel;
  wire                         GTPOWERGOOD;
  wire                         QPLL0LOCK_rd_sel;
  wire                         QPLL0LOCK;
  wire                         QPLL1LOCK_rd_sel;
  wire                         QPLL1LOCK;
  wire                         CPLLLOCK_rd_sel;
  wire                         CPLLLOCK;
  wire                         TXPMARESETDONE_rd_sel;
  wire                         TXPMARESETDONE;
  wire                         RXPMARESETDONE_rd_sel;
  wire                         RXPMARESETDONE;
  wire                         RESET_TX_DONE_rd_sel;
  wire                         RESET_TX_DONE;
  wire                         RESET_RX_DONE_rd_sel;
  wire                         RESET_RX_DONE;
  wire                         RXBUFSTATUS_rd_sel;
  wire   [2:0]                 RXBUFSTATUS;
  wire                         RXPRBSERR_rd_sel;
  wire                         RXPRBSERR;
  wire                         RXPRBSLOCKED_rd_sel;
  wire                         RXPRBSLOCKED;
  wire                         EYESCANRESET_wr_sel;
  wire                         EYESCANRESET_rd_sel;
  wire                         EYESCANTRIGGER_wr_sel;
  wire                         EYESCANTRIGGER_rd_sel;
  wire                         PCSRSVDIN_wr_sel;
  wire                         PCSRSVDIN_rd_sel;
  wire                         RXBUFRESET_wr_sel;
  wire                         RXBUFRESET_rd_sel;
  wire                         RXCDRHOLD_wr_sel;
  wire                         RXCDRHOLD_rd_sel;
  wire                         RXLPMEN_wr_sel;
  wire                         RXLPMEN_rd_sel;
  wire                         RXOUTCLKSEL_wr_sel;
  wire                         RXOUTCLKSEL_rd_sel;
  wire                         RXPOLARITY_wr_sel;
  wire                         RXPOLARITY_rd_sel;
  wire                         RXRATE_wr_sel;
  wire                         RXRATE_rd_sel;
  wire                         TXDIFFCTRL_wr_sel;
  wire                         TXDIFFCTRL_rd_sel;
  wire                         TXINHIBIT_wr_sel;
  wire                         TXINHIBIT_rd_sel;
  wire                         TXOUTCLKSEL_wr_sel;
  wire                         TXOUTCLKSEL_rd_sel;
  wire                         TXPOLARITY_wr_sel;
  wire                         TXPOLARITY_rd_sel;
  wire                         RESET_RX_CDR_STABLE_rd_sel;
  wire                         RESET_RX_CDR_STABLE;
  wire                         DMONITOROUT_rd_sel;
  wire   [15:0]                DMONITOROUT;
  wire                         EYESCANDATAERROR_rd_sel;
  wire                         EYESCANDATAERROR;
  wire                         RXCOMMADET_rd_sel;
  wire                         RXCOMMADET;
  wire                         RXCTRL1_rd_sel;
  wire   [15:0]                RXCTRL1;
  wire                         RXCTRL3_rd_sel;
  wire   [7:0]                 RXCTRL3;
  wire                         RXDLYSRESETDONE_rd_sel;
  wire                         RXDLYSRESETDONE;
  wire                         RXPHALIGNDONE_rd_sel;
  wire                         RXPHALIGNDONE;
  wire                         RXRESETDONE_rd_sel;
  wire                         RXRESETDONE;
  wire                         RXSYNCDONE_rd_sel;
  wire                         RXSYNCDONE;
  wire                         TXBUFSTATUS_rd_sel;
  wire   [1:0]                 TXBUFSTATUS;
  wire                         TXDLYSRESETDONE_rd_sel;
  wire                         TXDLYSRESETDONE;
  wire                         TXPHALIGNDONE_rd_sel;
  wire                         TXPHALIGNDONE;
  wire                         TXPHINITDONE_rd_sel;
  wire                         TXPHINITDONE;
  wire                         TXRESETDONE_rd_sel;
  wire                         TXRESETDONE;
  logic                        memrd_en_latch;
  logic                        lwr_en;
  logic  [63:0]                lwr_data;
  logic  [63:0]                ldata;
  logic                        memrd_en;
  logic                        memrd_v;
  logic                        WREG_RESET_ALL;
  logic                        WREG_RESET_TX_PLL_AND_DATAPATH;
  logic                        WREG_RESET_TX_DATAPATH;
  logic                        WREG_RESET_RX_PLL_AND_DATAPATH;
  logic                        WREG_RESET_RX_DATAPATH;
  logic                        WREG_LINK_DOWN_LATCHED_RESET;
  logic                        WREG_TXPMARESET;
  logic                        WREG_RXPMARESET;
  logic                        WREG_TXPCSRESET;
  logic                        WREG_RXPCSRESET;
  logic                        WREG_RXDFELPMRESET;
  logic  [4:0]                 WREG_TXPRECURSOR;
  logic  [4:0]                 WREG_TXPOSTCURSOR;
  logic  [2:0]                 WREG_LOOPBACK;
  logic  [3:0]                 WREG_TXPRBSSEL;
  logic  [3:0]                 WREG_RXPRBSSEL;
  logic                        WREG_TXPRBSFORCEERR;
  logic                        WREG_RXPRBSCNTRESET;
  logic                        WREG_EYESCANRESET;
  logic                        WREG_EYESCANTRIGGER;
  logic  [15:0]                WREG_PCSRSVDIN;
  logic                        WREG_RXBUFRESET;
  logic                        WREG_RXCDRHOLD;
  logic                        WREG_RXLPMEN;
  logic  [2:0]                 WREG_RXOUTCLKSEL;
  logic                        WREG_RXPOLARITY;
  logic  [2:0]                 WREG_RXRATE;
  logic  [4:0]                 WREG_TXDIFFCTRL;
  logic                        WREG_TXINHIBIT;
  logic  [2:0]                 WREG_TXOUTCLKSEL;
  logic                        WREG_TXPOLARITY;

// address decode
  assign RESET_ALL_wr_sel                         = (addr[9:0] == 10'h0     ) & (lwr_en == 1'b1);
  assign RESET_ALL_rd_sel                         = (addr[9:0] == 10'h0     ) & (rd_en == 1'b1);
  assign RESET_TX_PLL_AND_DATAPATH_wr_sel         = (addr[9:0] == 10'h1     ) & (lwr_en == 1'b1);
  assign RESET_TX_PLL_AND_DATAPATH_rd_sel         = (addr[9:0] == 10'h1     ) & (rd_en == 1'b1);
  assign RESET_TX_DATAPATH_wr_sel                 = (addr[9:0] == 10'h2     ) & (lwr_en == 1'b1);
  assign RESET_TX_DATAPATH_rd_sel                 = (addr[9:0] == 10'h2     ) & (rd_en == 1'b1);
  assign RESET_RX_PLL_AND_DATAPATH_wr_sel         = (addr[9:0] == 10'h3     ) & (lwr_en == 1'b1);
  assign RESET_RX_PLL_AND_DATAPATH_rd_sel         = (addr[9:0] == 10'h3     ) & (rd_en == 1'b1);
  assign RESET_RX_DATAPATH_wr_sel                 = (addr[9:0] == 10'h4     ) & (lwr_en == 1'b1);
  assign RESET_RX_DATAPATH_rd_sel                 = (addr[9:0] == 10'h4     ) & (rd_en == 1'b1);
  assign LINK_DOWN_LATCHED_RESET_wr_sel           = (addr[9:0] == 10'h5     ) & (lwr_en == 1'b1);
  assign LINK_DOWN_LATCHED_RESET_rd_sel           = (addr[9:0] == 10'h5     ) & (rd_en == 1'b1);
  assign TXPMARESET_wr_sel                        = (addr[9:0] == 10'h6     ) & (lwr_en == 1'b1);
  assign TXPMARESET_rd_sel                        = (addr[9:0] == 10'h6     ) & (rd_en == 1'b1);
  assign RXPMARESET_wr_sel                        = (addr[9:0] == 10'h7     ) & (lwr_en == 1'b1);
  assign RXPMARESET_rd_sel                        = (addr[9:0] == 10'h7     ) & (rd_en == 1'b1);
  assign TXPCSRESET_wr_sel                        = (addr[9:0] == 10'h8     ) & (lwr_en == 1'b1);
  assign TXPCSRESET_rd_sel                        = (addr[9:0] == 10'h8     ) & (rd_en == 1'b1);
  assign RXPCSRESET_wr_sel                        = (addr[9:0] == 10'h9     ) & (lwr_en == 1'b1);
  assign RXPCSRESET_rd_sel                        = (addr[9:0] == 10'h9     ) & (rd_en == 1'b1);
  assign RXDFELPMRESET_wr_sel                     = (addr[9:0] == 10'ha     ) & (lwr_en == 1'b1);
  assign RXDFELPMRESET_rd_sel                     = (addr[9:0] == 10'ha     ) & (rd_en == 1'b1);
  assign TXPRECURSOR_wr_sel                       = (addr[9:0] == 10'hb     ) & (lwr_en == 1'b1);
  assign TXPRECURSOR_rd_sel                       = (addr[9:0] == 10'hb     ) & (rd_en == 1'b1);
  assign TXPOSTCURSOR_wr_sel                      = (addr[9:0] == 10'hc     ) & (lwr_en == 1'b1);
  assign TXPOSTCURSOR_rd_sel                      = (addr[9:0] == 10'hc     ) & (rd_en == 1'b1);
  assign LOOPBACK_wr_sel                          = (addr[9:0] == 10'hd     ) & (lwr_en == 1'b1);
  assign LOOPBACK_rd_sel                          = (addr[9:0] == 10'hd     ) & (rd_en == 1'b1);
  assign TXPRBSSEL_wr_sel                         = (addr[9:0] == 10'he     ) & (lwr_en == 1'b1);
  assign TXPRBSSEL_rd_sel                         = (addr[9:0] == 10'he     ) & (rd_en == 1'b1);
  assign RXPRBSSEL_wr_sel                         = (addr[9:0] == 10'hf     ) & (lwr_en == 1'b1);
  assign RXPRBSSEL_rd_sel                         = (addr[9:0] == 10'hf     ) & (rd_en == 1'b1);
  assign TXPRBSFORCEERR_wr_sel                    = (addr[9:0] == 10'h10    ) & (lwr_en == 1'b1);
  assign TXPRBSFORCEERR_rd_sel                    = (addr[9:0] == 10'h10    ) & (rd_en == 1'b1);
  assign RXPRBSCNTRESET_wr_sel                    = (addr[9:0] == 10'h11    ) & (lwr_en == 1'b1);
  assign RXPRBSCNTRESET_rd_sel                    = (addr[9:0] == 10'h11    ) & (rd_en == 1'b1);
  assign LINK_STATUS_OUT_rd_sel                   = (addr[9:0] == 10'h12    ) & (rd_en == 1'b1);
  assign LINK_DOWN_rd_sel                         = (addr[9:0] == 10'h13    ) & (rd_en == 1'b1);
  assign INIT_DONE_rd_sel                         = (addr[9:0] == 10'h14    ) & (rd_en == 1'b1);
  assign INIT_RETRY_CTR_rd_sel                    = (addr[9:0] == 10'h15    ) & (rd_en == 1'b1);
  assign GTPOWERGOOD_rd_sel                       = (addr[9:0] == 10'h16    ) & (rd_en == 1'b1);
  assign QPLL0LOCK_rd_sel                         = (addr[9:0] == 10'h17    ) & (rd_en == 1'b1);
  assign QPLL1LOCK_rd_sel                         = (addr[9:0] == 10'h18    ) & (rd_en == 1'b1);
  assign CPLLLOCK_rd_sel                          = (addr[9:0] == 10'h19    ) & (rd_en == 1'b1);
  assign TXPMARESETDONE_rd_sel                    = (addr[9:0] == 10'h1a    ) & (rd_en == 1'b1);
  assign RXPMARESETDONE_rd_sel                    = (addr[9:0] == 10'h1b    ) & (rd_en == 1'b1);
  assign RESET_TX_DONE_rd_sel                     = (addr[9:0] == 10'h1c    ) & (rd_en == 1'b1);
  assign RESET_RX_DONE_rd_sel                     = (addr[9:0] == 10'h1d    ) & (rd_en == 1'b1);
  assign RXBUFSTATUS_rd_sel                       = (addr[9:0] == 10'h1e    ) & (rd_en == 1'b1);
  assign RXPRBSERR_rd_sel                         = (addr[9:0] == 10'h1f    ) & (rd_en == 1'b1);
  assign RXPRBSLOCKED_rd_sel                      = (addr[9:0] == 10'h20    ) & (rd_en == 1'b1);
  assign EYESCANRESET_wr_sel                      = (addr[9:0] == 10'h21    ) & (lwr_en == 1'b1);
  assign EYESCANRESET_rd_sel                      = (addr[9:0] == 10'h21    ) & (rd_en == 1'b1);
  assign EYESCANTRIGGER_wr_sel                    = (addr[9:0] == 10'h22    ) & (lwr_en == 1'b1);
  assign EYESCANTRIGGER_rd_sel                    = (addr[9:0] == 10'h22    ) & (rd_en == 1'b1);
  assign PCSRSVDIN_wr_sel                         = (addr[9:0] == 10'h23    ) & (lwr_en == 1'b1);
  assign PCSRSVDIN_rd_sel                         = (addr[9:0] == 10'h23    ) & (rd_en == 1'b1);
  assign RXBUFRESET_wr_sel                        = (addr[9:0] == 10'h24    ) & (lwr_en == 1'b1);
  assign RXBUFRESET_rd_sel                        = (addr[9:0] == 10'h24    ) & (rd_en == 1'b1);
  assign RXCDRHOLD_wr_sel                         = (addr[9:0] == 10'h25    ) & (lwr_en == 1'b1);
  assign RXCDRHOLD_rd_sel                         = (addr[9:0] == 10'h25    ) & (rd_en == 1'b1);
  assign RXLPMEN_wr_sel                           = (addr[9:0] == 10'h26    ) & (lwr_en == 1'b1);
  assign RXLPMEN_rd_sel                           = (addr[9:0] == 10'h26    ) & (rd_en == 1'b1);
  assign RXOUTCLKSEL_wr_sel                       = (addr[9:0] == 10'h27    ) & (lwr_en == 1'b1);
  assign RXOUTCLKSEL_rd_sel                       = (addr[9:0] == 10'h27    ) & (rd_en == 1'b1);
  assign RXPOLARITY_wr_sel                        = (addr[9:0] == 10'h28    ) & (lwr_en == 1'b1);
  assign RXPOLARITY_rd_sel                        = (addr[9:0] == 10'h28    ) & (rd_en == 1'b1);
  assign RXRATE_wr_sel                            = (addr[9:0] == 10'h29    ) & (lwr_en == 1'b1);
  assign RXRATE_rd_sel                            = (addr[9:0] == 10'h29    ) & (rd_en == 1'b1);
  assign TXDIFFCTRL_wr_sel                        = (addr[9:0] == 10'h2a    ) & (lwr_en == 1'b1);
  assign TXDIFFCTRL_rd_sel                        = (addr[9:0] == 10'h2a    ) & (rd_en == 1'b1);
  assign TXINHIBIT_wr_sel                         = (addr[9:0] == 10'h2b    ) & (lwr_en == 1'b1);
  assign TXINHIBIT_rd_sel                         = (addr[9:0] == 10'h2b    ) & (rd_en == 1'b1);
  assign TXOUTCLKSEL_wr_sel                       = (addr[9:0] == 10'h2c    ) & (lwr_en == 1'b1);
  assign TXOUTCLKSEL_rd_sel                       = (addr[9:0] == 10'h2c    ) & (rd_en == 1'b1);
  assign TXPOLARITY_wr_sel                        = (addr[9:0] == 10'h2d    ) & (lwr_en == 1'b1);
  assign TXPOLARITY_rd_sel                        = (addr[9:0] == 10'h2d    ) & (rd_en == 1'b1);
  assign RESET_RX_CDR_STABLE_rd_sel               = (addr[9:0] == 10'h2e    ) & (rd_en == 1'b1);
  assign DMONITOROUT_rd_sel                       = (addr[9:0] == 10'h2f    ) & (rd_en == 1'b1);
  assign EYESCANDATAERROR_rd_sel                  = (addr[9:0] == 10'h30    ) & (rd_en == 1'b1);
  assign RXCOMMADET_rd_sel                        = (addr[9:0] == 10'h31    ) & (rd_en == 1'b1);
  assign RXCTRL1_rd_sel                           = (addr[9:0] == 10'h32    ) & (rd_en == 1'b1);
  assign RXCTRL3_rd_sel                           = (addr[9:0] == 10'h33    ) & (rd_en == 1'b1);
  assign RXDLYSRESETDONE_rd_sel                   = (addr[9:0] == 10'h34    ) & (rd_en == 1'b1);
  assign RXPHALIGNDONE_rd_sel                     = (addr[9:0] == 10'h35    ) & (rd_en == 1'b1);
  assign RXRESETDONE_rd_sel                       = (addr[9:0] == 10'h36    ) & (rd_en == 1'b1);
  assign RXSYNCDONE_rd_sel                        = (addr[9:0] == 10'h37    ) & (rd_en == 1'b1);
  assign TXBUFSTATUS_rd_sel                       = (addr[9:0] == 10'h38    ) & (rd_en == 1'b1);
  assign TXDLYSRESETDONE_rd_sel                   = (addr[9:0] == 10'h39    ) & (rd_en == 1'b1);
  assign TXPHALIGNDONE_rd_sel                     = (addr[9:0] == 10'h3a    ) & (rd_en == 1'b1);
  assign TXPHINITDONE_rd_sel                      = (addr[9:0] == 10'h3b    ) & (rd_en == 1'b1);
  assign TXRESETDONE_rd_sel                       = (addr[9:0] == 10'h3c    ) & (rd_en == 1'b1);
  assign memrd_v = 1'b0;

  always_comb begin
    case(1'b1)
      RESET_ALL_rd_sel                         : ldata = {63'b0,WREG_RESET_ALL};
      RESET_TX_PLL_AND_DATAPATH_rd_sel         : ldata = {63'b0,WREG_RESET_TX_PLL_AND_DATAPATH};
      RESET_TX_DATAPATH_rd_sel                 : ldata = {63'b0,WREG_RESET_TX_DATAPATH};
      RESET_RX_PLL_AND_DATAPATH_rd_sel         : ldata = {63'b0,WREG_RESET_RX_PLL_AND_DATAPATH};
      RESET_RX_DATAPATH_rd_sel                 : ldata = {63'b0,WREG_RESET_RX_DATAPATH};
      LINK_DOWN_LATCHED_RESET_rd_sel           : ldata = {63'b0,WREG_LINK_DOWN_LATCHED_RESET};
      TXPMARESET_rd_sel                        : ldata = {63'b0,WREG_TXPMARESET};
      RXPMARESET_rd_sel                        : ldata = {63'b0,WREG_RXPMARESET};
      TXPCSRESET_rd_sel                        : ldata = {63'b0,WREG_TXPCSRESET};
      RXPCSRESET_rd_sel                        : ldata = {63'b0,WREG_RXPCSRESET};
      RXDFELPMRESET_rd_sel                     : ldata = {63'b0,WREG_RXDFELPMRESET};
      TXPRECURSOR_rd_sel                       : ldata = {59'b0,WREG_TXPRECURSOR};
      TXPOSTCURSOR_rd_sel                      : ldata = {59'b0,WREG_TXPOSTCURSOR};
      LOOPBACK_rd_sel                          : ldata = {61'b0,WREG_LOOPBACK};
      TXPRBSSEL_rd_sel                         : ldata = {60'b0,WREG_TXPRBSSEL};
      RXPRBSSEL_rd_sel                         : ldata = {60'b0,WREG_RXPRBSSEL};
      TXPRBSFORCEERR_rd_sel                    : ldata = {63'b0,WREG_TXPRBSFORCEERR};
      RXPRBSCNTRESET_rd_sel                    : ldata = {63'b0,WREG_RXPRBSCNTRESET};
      LINK_STATUS_OUT_rd_sel                   : ldata = {63'b0,LINK_STATUS_OUT};
      LINK_DOWN_rd_sel                         : ldata = {63'b0,LINK_DOWN};
      INIT_DONE_rd_sel                         : ldata = {63'b0,INIT_DONE};
      INIT_RETRY_CTR_rd_sel                    : ldata = {60'b0,INIT_RETRY_CTR};
      GTPOWERGOOD_rd_sel                       : ldata = {63'b0,GTPOWERGOOD};
      QPLL0LOCK_rd_sel                         : ldata = {63'b0,QPLL0LOCK};
      QPLL1LOCK_rd_sel                         : ldata = {63'b0,QPLL1LOCK};
      CPLLLOCK_rd_sel                          : ldata = {63'b0,CPLLLOCK};
      TXPMARESETDONE_rd_sel                    : ldata = {63'b0,TXPMARESETDONE};
      RXPMARESETDONE_rd_sel                    : ldata = {63'b0,RXPMARESETDONE};
      RESET_TX_DONE_rd_sel                     : ldata = {63'b0,RESET_TX_DONE};
      RESET_RX_DONE_rd_sel                     : ldata = {63'b0,RESET_RX_DONE};
      RXBUFSTATUS_rd_sel                       : ldata = {61'b0,RXBUFSTATUS};
      RXPRBSERR_rd_sel                         : ldata = {63'b0,RXPRBSERR};
      RXPRBSLOCKED_rd_sel                      : ldata = {63'b0,RXPRBSLOCKED};
      EYESCANRESET_rd_sel                      : ldata = {63'b0,WREG_EYESCANRESET};
      EYESCANTRIGGER_rd_sel                    : ldata = {63'b0,WREG_EYESCANTRIGGER};
      PCSRSVDIN_rd_sel                         : ldata = {48'b0,WREG_PCSRSVDIN};
      RXBUFRESET_rd_sel                        : ldata = {63'b0,WREG_RXBUFRESET};
      RXCDRHOLD_rd_sel                         : ldata = {63'b0,WREG_RXCDRHOLD};
      RXLPMEN_rd_sel                           : ldata = {63'b0,WREG_RXLPMEN};
      RXOUTCLKSEL_rd_sel                       : ldata = {61'b0,WREG_RXOUTCLKSEL};
      RXPOLARITY_rd_sel                        : ldata = {63'b0,WREG_RXPOLARITY};
      RXRATE_rd_sel                            : ldata = {61'b0,WREG_RXRATE};
      TXDIFFCTRL_rd_sel                        : ldata = {59'b0,WREG_TXDIFFCTRL};
      TXINHIBIT_rd_sel                         : ldata = {63'b0,WREG_TXINHIBIT};
      TXOUTCLKSEL_rd_sel                       : ldata = {61'b0,WREG_TXOUTCLKSEL};
      TXPOLARITY_rd_sel                        : ldata = {63'b0,WREG_TXPOLARITY};
      RESET_RX_CDR_STABLE_rd_sel               : ldata = {63'b0,RESET_RX_CDR_STABLE};
      DMONITOROUT_rd_sel                       : ldata = {48'b0,DMONITOROUT};
      EYESCANDATAERROR_rd_sel                  : ldata = {63'b0,EYESCANDATAERROR};
      RXCOMMADET_rd_sel                        : ldata = {63'b0,RXCOMMADET};
      RXCTRL1_rd_sel                           : ldata = {48'b0,RXCTRL1};
      RXCTRL3_rd_sel                           : ldata = {56'b0,RXCTRL3};
      RXDLYSRESETDONE_rd_sel                   : ldata = {63'b0,RXDLYSRESETDONE};
      RXPHALIGNDONE_rd_sel                     : ldata = {63'b0,RXPHALIGNDONE};
      RXRESETDONE_rd_sel                       : ldata = {63'b0,RXRESETDONE};
      RXSYNCDONE_rd_sel                        : ldata = {63'b0,RXSYNCDONE};
      TXBUFSTATUS_rd_sel                       : ldata = {62'b0,TXBUFSTATUS};
      TXDLYSRESETDONE_rd_sel                   : ldata = {63'b0,TXDLYSRESETDONE};
      TXPHALIGNDONE_rd_sel                     : ldata = {63'b0,TXPHALIGNDONE};
      TXPHINITDONE_rd_sel                      : ldata = {63'b0,TXPHINITDONE};
      TXRESETDONE_rd_sel                       : ldata = {63'b0,TXRESETDONE};
      default : ldata = {32'h5555_AAAA,{22{1'b0}},addr[9:0]};
    endcase
  end

// memrd latch
  assign memrd_en_latch = 1'b0;

// global ff
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       rd_data <= 64'h0;
       rd_data_v <= 1'b0;
       memrd_en <=  1'b0;
       lwr_en <=  1'b0;
       lwr_data <= 64'h0;
    end else begin
       lwr_en <= wr_en;
       lwr_data <= wr_data;
       memrd_en <= (memrd_en_latch | memrd_v)? ~memrd_en : memrd_en;
       rd_data <= (memrd_v | rd_en)? ldata : rd_data;
       rd_data_v <= ((wr_en|rd_en) & ~memrd_en_latch) | memrd_v;
    end
  end

 // rw: RESET_ALL
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RESET_ALL                           <= 1'h0;
    end else begin
       WREG_RESET_ALL                           <= (RESET_ALL_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RESET_ALL;
    end
  end

  assign oREG_RESET_ALL                           = WREG_RESET_ALL;
 // rw: RESET_TX_PLL_AND_DATAPATH
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RESET_TX_PLL_AND_DATAPATH           <= 1'h0;
    end else begin
       WREG_RESET_TX_PLL_AND_DATAPATH           <= (RESET_TX_PLL_AND_DATAPATH_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RESET_TX_PLL_AND_DATAPATH;
    end
  end

  assign oREG_RESET_TX_PLL_AND_DATAPATH           = WREG_RESET_TX_PLL_AND_DATAPATH;
 // rw: RESET_TX_DATAPATH
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RESET_TX_DATAPATH                   <= 1'h0;
    end else begin
       WREG_RESET_TX_DATAPATH                   <= (RESET_TX_DATAPATH_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RESET_TX_DATAPATH;
    end
  end

  assign oREG_RESET_TX_DATAPATH                   = WREG_RESET_TX_DATAPATH;
 // rw: RESET_RX_PLL_AND_DATAPATH
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RESET_RX_PLL_AND_DATAPATH           <= 1'h0;
    end else begin
       WREG_RESET_RX_PLL_AND_DATAPATH           <= (RESET_RX_PLL_AND_DATAPATH_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RESET_RX_PLL_AND_DATAPATH;
    end
  end

  assign oREG_RESET_RX_PLL_AND_DATAPATH           = WREG_RESET_RX_PLL_AND_DATAPATH;
 // rw: RESET_RX_DATAPATH
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RESET_RX_DATAPATH                   <= 1'h0;
    end else begin
       WREG_RESET_RX_DATAPATH                   <= (RESET_RX_DATAPATH_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RESET_RX_DATAPATH;
    end
  end

  assign oREG_RESET_RX_DATAPATH                   = WREG_RESET_RX_DATAPATH;
 // rw: LINK_DOWN_LATCHED_RESET
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_LINK_DOWN_LATCHED_RESET             <= 1'h0;
    end else begin
       WREG_LINK_DOWN_LATCHED_RESET             <= (LINK_DOWN_LATCHED_RESET_wr_sel == 1'b1)? lwr_data[0:0] : WREG_LINK_DOWN_LATCHED_RESET;
    end
  end

  assign oREG_LINK_DOWN_LATCHED_RESET             = WREG_LINK_DOWN_LATCHED_RESET;
 // rw: TXPMARESET
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_TXPMARESET                          <= 1'h0;
    end else begin
       WREG_TXPMARESET                          <= (TXPMARESET_wr_sel == 1'b1)? lwr_data[0:0] : WREG_TXPMARESET;
    end
  end

  assign oREG_TXPMARESET                          = WREG_TXPMARESET;
 // rw: RXPMARESET
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXPMARESET                          <= 1'h0;
    end else begin
       WREG_RXPMARESET                          <= (RXPMARESET_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RXPMARESET;
    end
  end

  assign oREG_RXPMARESET                          = WREG_RXPMARESET;
 // rw: TXPCSRESET
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_TXPCSRESET                          <= 1'h0;
    end else begin
       WREG_TXPCSRESET                          <= (TXPCSRESET_wr_sel == 1'b1)? lwr_data[0:0] : WREG_TXPCSRESET;
    end
  end

  assign oREG_TXPCSRESET                          = WREG_TXPCSRESET;
 // rw: RXPCSRESET
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXPCSRESET                          <= 1'h0;
    end else begin
       WREG_RXPCSRESET                          <= (RXPCSRESET_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RXPCSRESET;
    end
  end

  assign oREG_RXPCSRESET                          = WREG_RXPCSRESET;
 // rw: RXDFELPMRESET
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXDFELPMRESET                       <= 1'h0;
    end else begin
       WREG_RXDFELPMRESET                       <= (RXDFELPMRESET_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RXDFELPMRESET;
    end
  end

  assign oREG_RXDFELPMRESET                       = WREG_RXDFELPMRESET;
 // rw: TXPRECURSOR
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_TXPRECURSOR                         <= 5'h0;
    end else begin
       WREG_TXPRECURSOR                         <= (TXPRECURSOR_wr_sel == 1'b1)? lwr_data[4:0] : WREG_TXPRECURSOR;
    end
  end

  assign oREG_TXPRECURSOR                         = WREG_TXPRECURSOR[4:0];
 // rw: TXPOSTCURSOR
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_TXPOSTCURSOR                        <= 5'h0;
    end else begin
       WREG_TXPOSTCURSOR                        <= (TXPOSTCURSOR_wr_sel == 1'b1)? lwr_data[4:0] : WREG_TXPOSTCURSOR;
    end
  end

  assign oREG_TXPOSTCURSOR                        = WREG_TXPOSTCURSOR[4:0];
 // rw: LOOPBACK
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_LOOPBACK                            <= 3'h0;
    end else begin
       WREG_LOOPBACK                            <= (LOOPBACK_wr_sel == 1'b1)? lwr_data[2:0] : WREG_LOOPBACK;
    end
  end

  assign oREG_LOOPBACK                            = WREG_LOOPBACK[2:0];
 // rw: TXPRBSSEL
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_TXPRBSSEL                           <= 4'h0;
    end else begin
       WREG_TXPRBSSEL                           <= (TXPRBSSEL_wr_sel == 1'b1)? lwr_data[3:0] : WREG_TXPRBSSEL;
    end
  end

  assign oREG_TXPRBSSEL                           = WREG_TXPRBSSEL[3:0];
 // rw: RXPRBSSEL
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXPRBSSEL                           <= 4'h0;
    end else begin
       WREG_RXPRBSSEL                           <= (RXPRBSSEL_wr_sel == 1'b1)? lwr_data[3:0] : WREG_RXPRBSSEL;
    end
  end

  assign oREG_RXPRBSSEL                           = WREG_RXPRBSSEL[3:0];
 // rw: TXPRBSFORCEERR
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_TXPRBSFORCEERR                      <= 1'h0;
    end else begin
       WREG_TXPRBSFORCEERR                      <= (TXPRBSFORCEERR_wr_sel == 1'b1)? lwr_data[0:0] : WREG_TXPRBSFORCEERR;
    end
  end

  assign oREG_TXPRBSFORCEERR                      = WREG_TXPRBSFORCEERR;
 // rw: RXPRBSCNTRESET
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXPRBSCNTRESET                      <= 1'h0;
    end else begin
       WREG_RXPRBSCNTRESET                      <= (RXPRBSCNTRESET_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RXPRBSCNTRESET;
    end
  end

  assign oREG_RXPRBSCNTRESET                      = WREG_RXPRBSCNTRESET;
 // ro: LINK_STATUS_OUT
  assign LINK_STATUS_OUT                          = iREG_LINK_STATUS_OUT;

 // ro: LINK_DOWN
  assign LINK_DOWN                                = iREG_LINK_DOWN;

 // ro: INIT_DONE
  assign INIT_DONE                                = iREG_INIT_DONE;

 // ro: INIT_RETRY_CTR
  assign INIT_RETRY_CTR                           = iREG_INIT_RETRY_CTR[3:0];

 // ro: GTPOWERGOOD
  assign GTPOWERGOOD                              = iREG_GTPOWERGOOD;

 // ro: QPLL0LOCK
  assign QPLL0LOCK                                = iREG_QPLL0LOCK;

 // ro: QPLL1LOCK
  assign QPLL1LOCK                                = iREG_QPLL1LOCK;

 // ro: CPLLLOCK
  assign CPLLLOCK                                 = iREG_CPLLLOCK;

 // ro: TXPMARESETDONE
  assign TXPMARESETDONE                           = iREG_TXPMARESETDONE;

 // ro: RXPMARESETDONE
  assign RXPMARESETDONE                           = iREG_RXPMARESETDONE;

 // ro: RESET_TX_DONE
  assign RESET_TX_DONE                            = iREG_RESET_TX_DONE;

 // ro: RESET_RX_DONE
  assign RESET_RX_DONE                            = iREG_RESET_RX_DONE;

 // ro: RXBUFSTATUS
  assign RXBUFSTATUS                              = iREG_RXBUFSTATUS[2:0];

 // ro: RXPRBSERR
  assign RXPRBSERR                                = iREG_RXPRBSERR;

 // ro: RXPRBSLOCKED
  assign RXPRBSLOCKED                             = iREG_RXPRBSLOCKED;

 // rw: EYESCANRESET
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_EYESCANRESET                        <= 1'h0;
    end else begin
       WREG_EYESCANRESET                        <= (EYESCANRESET_wr_sel == 1'b1)? lwr_data[0:0] : WREG_EYESCANRESET;
    end
  end

  assign oREG_EYESCANRESET                        = WREG_EYESCANRESET;
 // rw: EYESCANTRIGGER
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_EYESCANTRIGGER                      <= 1'h0;
    end else begin
       WREG_EYESCANTRIGGER                      <= (EYESCANTRIGGER_wr_sel == 1'b1)? lwr_data[0:0] : WREG_EYESCANTRIGGER;
    end
  end

  assign oREG_EYESCANTRIGGER                      = WREG_EYESCANTRIGGER;
 // rw: PCSRSVDIN
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_PCSRSVDIN                           <= 16'h0;
    end else begin
       WREG_PCSRSVDIN                           <= (PCSRSVDIN_wr_sel == 1'b1)? lwr_data[15:0] : WREG_PCSRSVDIN;
    end
  end

  assign oREG_PCSRSVDIN                           = WREG_PCSRSVDIN[15:0];
 // rw: RXBUFRESET
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXBUFRESET                          <= 1'h0;
    end else begin
       WREG_RXBUFRESET                          <= (RXBUFRESET_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RXBUFRESET;
    end
  end

  assign oREG_RXBUFRESET                          = WREG_RXBUFRESET;
 // rw: RXCDRHOLD
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXCDRHOLD                           <= 1'h0;
    end else begin
       WREG_RXCDRHOLD                           <= (RXCDRHOLD_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RXCDRHOLD;
    end
  end

  assign oREG_RXCDRHOLD                           = WREG_RXCDRHOLD;
 // rw: RXLPMEN
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXLPMEN                             <= 1'h1;
    end else begin
       WREG_RXLPMEN                             <= (RXLPMEN_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RXLPMEN;
    end
  end

  assign oREG_RXLPMEN                             = WREG_RXLPMEN;
 // rw: RXOUTCLKSEL
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXOUTCLKSEL                         <= 3'h2;
    end else begin
       WREG_RXOUTCLKSEL                         <= (RXOUTCLKSEL_wr_sel == 1'b1)? lwr_data[2:0] : WREG_RXOUTCLKSEL;
    end
  end

  assign oREG_RXOUTCLKSEL                         = WREG_RXOUTCLKSEL[2:0];
 // rw: RXPOLARITY
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXPOLARITY                          <= 1'h0;
    end else begin
       WREG_RXPOLARITY                          <= (RXPOLARITY_wr_sel == 1'b1)? lwr_data[0:0] : WREG_RXPOLARITY;
    end
  end

  assign oREG_RXPOLARITY                          = WREG_RXPOLARITY;
 // rw: RXRATE
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_RXRATE                              <= 3'h0;
    end else begin
       WREG_RXRATE                              <= (RXRATE_wr_sel == 1'b1)? lwr_data[2:0] : WREG_RXRATE;
    end
  end

  assign oREG_RXRATE                              = WREG_RXRATE[2:0];
 // rw: TXDIFFCTRL
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_TXDIFFCTRL                          <= 5'h18;
    end else begin
       WREG_TXDIFFCTRL                          <= (TXDIFFCTRL_wr_sel == 1'b1)? lwr_data[4:0] : WREG_TXDIFFCTRL;
    end
  end

  assign oREG_TXDIFFCTRL                          = WREG_TXDIFFCTRL[4:0];
 // rw: TXINHIBIT
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_TXINHIBIT                           <= 1'h0;
    end else begin
       WREG_TXINHIBIT                           <= (TXINHIBIT_wr_sel == 1'b1)? lwr_data[0:0] : WREG_TXINHIBIT;
    end
  end

  assign oREG_TXINHIBIT                           = WREG_TXINHIBIT;
 // rw: TXOUTCLKSEL
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_TXOUTCLKSEL                         <= 3'h2;
    end else begin
       WREG_TXOUTCLKSEL                         <= (TXOUTCLKSEL_wr_sel == 1'b1)? lwr_data[2:0] : WREG_TXOUTCLKSEL;
    end
  end

  assign oREG_TXOUTCLKSEL                         = WREG_TXOUTCLKSEL[2:0];
 // rw: TXPOLARITY
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
       WREG_TXPOLARITY                          <= 1'h0;
    end else begin
       WREG_TXPOLARITY                          <= (TXPOLARITY_wr_sel == 1'b1)? lwr_data[0:0] : WREG_TXPOLARITY;
    end
  end

  assign oREG_TXPOLARITY                          = WREG_TXPOLARITY;
 // ro: RESET_RX_CDR_STABLE
  assign RESET_RX_CDR_STABLE                      = iREG_RESET_RX_CDR_STABLE;

 // ro: DMONITOROUT
  assign DMONITOROUT                              = iREG_DMONITOROUT[15:0];

 // ro: EYESCANDATAERROR
  assign EYESCANDATAERROR                         = iREG_EYESCANDATAERROR;

 // ro: RXCOMMADET
  assign RXCOMMADET                               = iREG_RXCOMMADET;

 // ro: RXCTRL1
  assign RXCTRL1                                  = iREG_RXCTRL1[15:0];

 // ro: RXCTRL3
  assign RXCTRL3                                  = iREG_RXCTRL3[7:0];

 // ro: RXDLYSRESETDONE
  assign RXDLYSRESETDONE                          = iREG_RXDLYSRESETDONE;

 // ro: RXPHALIGNDONE
  assign RXPHALIGNDONE                            = iREG_RXPHALIGNDONE;

 // ro: RXRESETDONE
  assign RXRESETDONE                              = iREG_RXRESETDONE;

 // ro: RXSYNCDONE
  assign RXSYNCDONE                               = iREG_RXSYNCDONE;

 // ro: TXBUFSTATUS
  assign TXBUFSTATUS                              = iREG_TXBUFSTATUS[1:0];

 // ro: TXDLYSRESETDONE
  assign TXDLYSRESETDONE                          = iREG_TXDLYSRESETDONE;

 // ro: TXPHALIGNDONE
  assign TXPHALIGNDONE                            = iREG_TXPHALIGNDONE;

 // ro: TXPHINITDONE
  assign TXPHINITDONE                             = iREG_TXPHINITDONE;

 // ro: TXRESETDONE
  assign TXRESETDONE                              = iREG_TXRESETDONE;

endmodule
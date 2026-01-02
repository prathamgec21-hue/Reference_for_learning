// ---------------------------------------------------------------------
// File Name    : tb.sv 
// Description  : Define testbench top env
// Developers   : jeje (jejepark@samsung.com)
// Created      : 22:26:55 30-Jun-2017
// Generator    : vbuilder v201702 based on sec_UVM v201702     
// ---------------------------------------------------------------------
// Copyright2017(c) Samsung Electronics Co., Ltd. All rights reserved.
// ---------------------------------------------------------------------

`ifndef SUV_TB_C
`define SUV_TB_C

package prim_pkg;

// ---------------------------------------------------------------
// Import UVM packages.
// ---------------------------------------------------------------
import uvm_pkg::*;  
`include "uvm_macros.svh"

// ---------------------------------------------------------------
// Import PureSpec AXI packages.
// ---------------------------------------------------------------
`ifdef SUV_CDN_PS_AXI
// Cadence PureSpec AXI packages
import DenaliSvCdn_axi::*;
import DenaliSvMem::*;
import cdnAxiUvm::*;
// User specific package
import cdn_ps_axi_pkg::*;
`endif // SUV_CDN_PS_AXI

// ---------------------------------------------------------------
// Import PureSpec AMBA_LPI packages.
// ---------------------------------------------------------------
`ifdef SUV_CDN_AMBA_LPI
import DenaliSvAmba_lpi::*;
import DenaliSvMem::*;
// Include the VIP UVM base classes
import cdnAmba_lpiUvm::*;
// User specific package
import cdn_amba_lpi_pkg::*;
`endif // SUV_CDN_AMBA_LPI

// ---------------------------------------------------------------
// Import PureSpec AHB UVC packages.
// ---------------------------------------------------------------

//niha,
`ifdef SSC_EN
//`ifdef SUV_CDN_PS_AHB
// Cadence PureSpec AHB packages
import DenaliSvCdn_ahb::*;
import DenaliSvMem::*;
import cdnAhbUvm::*;
// User specific package
import cdn_ps_ahb_pkg::*;
//`endif // SUV_CDN_PS_AHB
`endif

`ifdef TRNG_EN
//`ifdef SUV_CDN_PS_AHB
// Cadence PureSpec AHB packages
import DenaliSvCdn_ahb::*;
import DenaliSvMem::*;
import cdnAhbUvm::*;
// User specific package
import cdn_ps_ahb_pkg::*;
//`endif // SUV_CDN_PS_AHB
`endif

`ifdef SUV_CDN_PS_APB
// Cadence PureSpec APB packages
import DenaliSvMem::*;
import DenaliSvCdn_apb::*;
import cdnApbUvm::*;
//user specific package
import cdn_ps_apb_pkg::*;
`endif // SUV_CDN_PS_APB

`ifdef PKC_EN
//`ifdef SUV_CDN_PS_AHB
// Cadence PureSpec AHB packages
import DenaliSvCdn_ahb::*;
import DenaliSvMem::*;
import cdnAhbUvm::*;
// User specific package
import cdn_ps_ahb_pkg::*;
//`endif // SUV_CDN_PS_AHB
`endif

// ---------------------------------------------------------------
// Import APB UVC packages.
// ---------------------------------------------------------------
`ifdef SUV_SEC_APB
import sec_apb::*;
`endif // SUV_SEC_APB

// ---------------------------------------------------------------
// Include register files.
// Register files are placed under "lib/reg_def" directory
// ---------------------------------------------------------------
`include "reg_def.svh"

// ---------------------------------------------------------------
// Include register adpater for AHB UVC.
// ---------------------------------------------------------------
//`ifdef SUV_CDN_PS_AHB
//niha
`ifdef SSC_EN
`include "cdn_ps_ahb_reg_adp.sv"
`endif

`ifdef PKC_EN
`include "cdn_ps_ahb_reg_adp.sv"
`endif // PKC_EN
//`endif // SUV_CDN_PS_AHB
// ---------------------------------------------------------------
// Include register adpater for APB UVC.
// ---------------------------------------------------------------
`ifdef SUV_SEC_APB
`include "sec_apb_reg_adp.sv"
`endif // SUV_SEC_APB

`ifdef ARGON2_VE
`include "argon2_cfg.sv"
`include "argon2_tran.sv"
`include "argon2_sequencer.sv"
`include "argon2_driver.sv"
`endif

//import spx_pkg::*;
`ifdef SPX_VE
`include "spx_pkt.sv"
`include "spx_sequencer.sv"
`include "spx_driver.sv"
`endif//SPX_VE

// ---------------------------------------------------------------
// Include virtual sequencer.
// ---------------------------------------------------------------
`include "vseqr.sv"

// ---------------------------------------------------------------
// Testbench top class
// ---------------------------------------------------------------
class tb_c extends uvm_env;       

   // ---------------------------------------------------------------
   // Interface UVCs
   // ---------------------------------------------------------------
   // ---------------------------------------------------------------
   // PureSpec AXI UVC env
   // ---------------------------------------------------------------
   `ifdef SUV_CDN_PS_AXI
   `ifdef SUV_CDN_PS_AXI_IF0
   // AXI_IF0
   cdn_ps_axi_if_env_c cdn_ps_axi_if0_env;
   `endif // SUV_CDN_PS_AXI_IF0
   `endif // SUV_CDN_PS_AXI

   // ---------------------------------------------------------------
   // SEC APB UVC env
   // ---------------------------------------------------------------
   `ifdef SUV_SEC_APB

   `ifdef SUV_SEC_APB0
   sec_apb_env_c sec_apb0_env; 
   `endif // SUV_SEC_APB0

   `ifdef SUV_SEC_APB1
   sec_apb_env_c sec_apb1_env; 
   `endif // SUV_SEC_APB1

   `endif // SUV_SEC_APB

   `ifdef SUV_CDN_PS_APB
    cdn_ps_apb_env_c apb0_env; //gps3 
   `endif // SUV_CDN_PS_APB
   // ---------------------------------------------------------------
   // PureSpec AMBA_LPI UVC env
   // ---------------------------------------------------------------
   `ifdef SUV_CDN_AMBA_LPI
   cdn_amba_lpi_env_c cdn_amba_lpi_env;
   `endif // SUV_CDN_AMBA_LPI

   // ---------------------------------------------------------------
   // PureSpec AHB UVC env
   // ---------------------------------------------------------------
   //niha
   `ifdef SSC_EN
   cdn_ps_ahb_env_c cdn_ps_ahb_ssc_env;
   `endif
   `ifdef TRNG_EN
   cdn_ps_ahb_env_c cdn_ps_ahb_trng_env;
   `endif
   `ifdef SUV_CDN_PS_AHB
    `ifndef SSS_LITE
   cdn_ps_ahb_env_c cdn_ps_ahb0_env;
   cdn_ps_ahb_mon_c cdn_ps_ahb0_mon_cmzs;    // Cortex-M0 AHB Passive Slave Monitor
   cdn_ps_ahb_mon_c cdn_ps_ahb0_mon_sdma;    // SDMA AHB Passive Master Monitor
    `else
   cdn_ps_ahb_env_c cdn_ps_ahb0_env;
   cdn_ps_ahb_env_c cdn_ps_ahb1_env;
    cdn_ps_ahb_env_c cdn_ps_ahb_ssc_env;
   `ifdef ARGON2_VE
   cdn_ps_ahb_env_c cdn_ps_ahb_argon2_env;
   `endif
   `ifdef PKC_VE
   cdn_ps_ahb_env_c cdn_ps_ahb_pkc_env;
   cdn_ps_ahb_mon_c cdn_ps_ahb_mon_pkc;    // SDMA AHB Passive Master Monitor
   `endif //PKC_VE
    `endif
   `endif // SUV_CDN_PS_AHB

   `ifdef PKC_EN
   cdn_ps_ahb_env_c cdn_ps_ahb_pkc_env;
   cdn_ps_ahb_mon_c cdn_ps_ahb_mon_pkc;    // SDMA AHB Passive Master Monitor
   cdn_ps_ahb_env_c cdn_ps_ahb_trng_env;
   `endif //PKC_EN
   // ---------------------------------------------------------------
   // Virtual sequencer
   // ---------------------------------------------------------------
   vseqr_c vseqr; 

   // ---------------------------------------------------------------
   // Register
   // ---------------------------------------------------------------
   reg_blk_c reg_blk;
   //niha
   `ifdef SSC_EN
   cdn_ps_ahb_reg_adp_c cdn_ps_ahb_ssc_reg_adp; //TBDJ
   uvm_reg_predictor#(denaliCdn_ahbTransaction) cdn_ps_ahb_ssc_reg_prd; //TBDJ
   `endif
   `ifdef SUV_CDN_PS_AHB
   // ---------------------------------------------------------------
   // Adapter for AHB interface
   // This translates the transaction between register and AHB.
   // ---------------------------------------------------------------
   cdn_ps_ahb_reg_adp_c cdn_ps_ahb0_reg_adp;
   cdn_ps_ahb_reg_adp_c cdn_ps_ahb_ssc_reg_adp; //TBDJ
//   cdn_ps_ahb_reg_adp_c cdn_ps_ahb0_reg_adp2;
//   cdn_ps_ahb_reg_adp_c cdn_ps_ahb0_reg_adp3;

   // ---------------------------------------------------------------
   // Predictor for AHB interface
   // This is provided from UVM library and updates and 
   // compares register.
   // ---------------------------------------------------------------
   uvm_reg_predictor#(denaliCdn_ahbTransaction) cdn_ps_ahb0_reg_prd;
   uvm_reg_predictor#(denaliCdn_ahbTransaction) cdn_ps_ahb_ssc_reg_prd; //TBDJ
//   uvm_reg_predictor#(denaliCdn_ahbTransaction) cdn_ps_ahb0_reg_prd2;
//   uvm_reg_predictor#(denaliCdn_ahbTransaction) cdn_ps_ahb0_reg_prd3;
    
    `ifdef PKC_VE
        cdn_ps_ahb_reg_adp_c cdn_ps_ahb_pkc_reg_adp;
        uvm_reg_predictor#(denaliCdn_ahbTransaction) cdn_ps_ahb_pkc_reg_prd;
    `endif //PKC_VE

   `endif // SUV_CDN_PS_AHB

    `ifdef PKC_EN
        cdn_ps_ahb_reg_adp_c cdn_ps_ahb_pkc_reg_adp;
        uvm_reg_predictor#(denaliCdn_ahbTransaction) cdn_ps_ahb_pkc_reg_prd;
    `endif //PKC_EN

    `ifdef SUV_CDN_PS_APB
    cdn_ps_apb_reg_adp_c apb0_reg_adp0;
   `endif // SUV_CDN_PS_APB

   `ifdef SUV_CDN_PS_APB
    uvm_reg_predictor#(denaliCdn_apbTransaction) apb0_reg_prd0;
   `endif // SUV_CDN_PS_APB

   `ifdef SUV_SEC_APB
   `ifdef SUV_SEC_APB0
   // ---------------------------------------------------------------
   // Adapter for APB interface
   // This translates the transaction between register and APB.
   // ---------------------------------------------------------------
   sec_apb_reg_adp_c sec_apb0_reg_adp;
   // ---------------------------------------------------------------
   // Predictor for APB interface
   // This is provided from UVM library and updates and 
   // compares register.
   // ---------------------------------------------------------------
   uvm_reg_predictor#(sec_apb_trans_c) sec_apb0_reg_prd;
   `endif // SUV_SEC_APB0
   
   `ifdef SUV_SEC_APB1
   // ---------------------------------------------------------------
   // Adapter for APB interface
   // This translates the transaction between register and APB.
   // ---------------------------------------------------------------
   sec_apb_reg_adp_c sec_apb1_reg_adp;
   // ---------------------------------------------------------------
   // Predictor for APB interface
   // This is provided from UVM library and updates and 
   // This is provided from UVM library and updates and 
   // compares register.
   // ---------------------------------------------------------------
   uvm_reg_predictor#(sec_apb_trans_c) sec_apb1_reg_prd;
   `endif // SUV_SEC_APB1
 
   `endif // SUV_SEC_APB

   `uvm_component_utils_begin(tb_c)
      `uvm_field_object(reg_blk, UVM_REFERENCE)
   `uvm_component_utils_end

   function new(string name = "tb_c", uvm_component parent = null);
      super.new(name, parent);
      `uvm_info(get_full_name(), "new() ...", UVM_FULL)
      // CDS
      set_type_override_by_type(cdnAxiUvmMonitor::get_type(),cdnAxiUvmUserMonitor::get_type());
      `uvm_info(get_type_name(), "new() ...", UVM_HIGH)

   endfunction: new

   // ---------------------------------------------------------------
   // Build
   // Configure and construct components.
   // ---------------------------------------------------------------
   virtual function void build_phase(uvm_phase phase);       

      super.build_phase(phase);

      `uvm_info(get_full_name(), "build_phase() ...", UVM_FULL)

      // ---------------------------------------------------------------
      // UVCs configuration & construction.
      // Configuration should be done before components are created.
      // ---------------------------------------------------------------

      // ---------------------------------------------------------------
      // PureSpec AXI configuration & construction.
      // config_cdn_ps_axi() is a function to configure AXI.
      // ---------------------------------------------------------------
      `ifdef SUV_CDN_PS_AXI

      config_cdn_ps_axi();

      `ifdef SUV_CDN_PS_AXI_IF0
      // AXI_IF0
      cdn_ps_axi_if0_env = cdn_ps_axi_if_env_c::type_id::create("cdn_ps_axi_if0_env", this);
      `endif // SUV_CDN_PS_AXI_IF0
      `endif // SUV_CDN_PS_AXI

      // ---------------------------------------------------------------
      // PureSpec AMBA_LPI configuration & construction.
      // config_cdn_amba_lpi() is a function to configure cdn_amba_lpi.
      // ---------------------------------------------------------------
      `ifdef SUV_CDN_AMBA_LPI
      config_cdn_amba_lpi();
	  cdn_amba_lpi_env = cdn_amba_lpi_env_c::type_id::create("cdn_amba_lpi_env", this);   
      `endif // SUV_CDN_AMBA_LPI

      // ---------------------------------------------------------------
      // PureSpec AHB configuration & construction.
      // config_cdn_ps_ahb() is a function to configure AHB.
      // ---------------------------------------------------------------
//niha
    `ifdef SSC_EN
    cdn_ps_ahb_ssc_env = cdn_ps_ahb_env_c::type_id::create("cdn_ps_ahb_ssc_env", this);
      config_cdn_ps_ahb();
    `endif
     `ifdef TRNG_EN
      cdn_ps_ahb_trng_env = cdn_ps_ahb_env_c::type_id::create("cdn_ps_ahb_trng_env", this);
      config_cdn_ps_ahb_trng();
      `endif
      `ifdef SUV_CDN_PS_AHB
      config_cdn_ps_ahb();
      cdn_ps_ahb0_env = cdn_ps_ahb_env_c::type_id::create("cdn_ps_ahb0_env", this);
      cdn_ps_ahb1_env = cdn_ps_ahb_env_c::type_id::create("cdn_ps_ahb1_env", this);
    cdn_ps_ahb_ssc_env = cdn_ps_ahb_env_c::type_id::create("cdn_ps_ahb_ssc_env", this);
     `ifdef ARGON2_VE
      cdn_ps_ahb_argon2_env = cdn_ps_ahb_env_c::type_id::create("cdn_ps_ahb_argon2_env", this);
      `endif

      `ifdef PKC_VE
      config_cdn_ps_ahb_pkc();
      cdn_ps_ahb_pkc_env = cdn_ps_ahb_env_c::type_id::create("cdn_ps_ahb_pkc_env", this);

      `endif //PKC_VE
      `endif // SUV_CDN_PS_AHB

      `ifdef PKC_EN
      config_cdn_ps_ahb_pkc();
      cdn_ps_ahb_pkc_env = cdn_ps_ahb_env_c::type_id::create("cdn_ps_ahb_pkc_env", this);
      cdn_ps_ahb_trng_env = cdn_ps_ahb_env_c::type_id::create("cdn_ps_ahb_trng_env", this);
      config_cdn_ps_ahb_trng();

      `endif //PKC_EN
      // ---------------------------------------------------------------
      // SEC APB configuration & construction.
      // config_sec_apb() is a function to configure APB.
      // ---------------------------------------------------------------

      `ifdef SUV_SEC_APB
      config_sec_apb();

      `ifdef SUV_SEC_APB0
      sec_apb0_env = sec_apb_env_c::type_id::create("sec_apb0_env", this);
      `endif // SUV_SEC_APB0

      `ifdef SUV_SEC_APB1
      sec_apb1_env = sec_apb_env_c::type_id::create("sec_apb1_env", this);
      `endif // SUV_SEC_APB1


      `endif // SUV_SEC_APB
      `ifdef SUV_CDN_PS_APB
      config_cdn_ps_apb();
      apb0_env = cdn_ps_apb_env_c::type_id::create("apb0_env", this);
      `endif // SUV_CDN_PS_APB

      // ---------------------------------------------------------------
      // Construct virtual sequencer.
      // ---------------------------------------------------------------
      uvm_config_db#(int)::set(this, "vseqr", "count",  1);
      vseqr = vseqr_c::type_id::create("vseqr", this);

      // ---------------------------------------------------------------
      // Construct register model.
      // ---------------------------------------------------------------
      if(reg_blk == null) begin
         reg_blk = reg_blk_c::type_id::create("reg_blk");
         reg_blk.build();
         reg_blk.lock_model();
         reg_blk.set_hdl_path_root(`TEST_TOP_STR);
         `uvm_info(get_full_name(), {"register model:\n", reg_blk.sprint()}, UVM_FULL)
      end

      // ---------------------------------------------------------------
      // Construct predictor.
      // ---------------------------------------------------------------
      if($test$plusargs("AUTO_PREDICT")) begin
      end else begin
//niha
        `ifdef SSC_EN
          cdn_ps_ahb_ssc_reg_prd = uvm_reg_predictor#(denaliCdn_ahbTransaction)::type_id::create("cdn_ps_ahb_ssc_reg_prd", this); //TBDJ
      `endif
         `ifdef SUV_CDN_PS_AHB
          cdn_ps_ahb0_reg_prd = uvm_reg_predictor#(denaliCdn_ahbTransaction)::type_id::create("cdn_ps_ahb0_reg_prd", this);
          cdn_ps_ahb_ssc_reg_prd = uvm_reg_predictor#(denaliCdn_ahbTransaction)::type_id::create("cdn_ps_ahb_ssc_reg_prd", this); //TBDJ
          `ifdef PKC_VE
        cdn_ps_ahb_pkc_reg_prd = uvm_reg_predictor#(denaliCdn_ahbTransaction)::type_id::create("cdn_ps_ahb_pkc_reg_prd",this);
          `endif //PKC_VE
//          cdn_ps_ahb0_reg_prd2 = uvm_reg_predictor#(denaliCdn_ahbTransaction)::type_id::create("cdn_ps_ahb0_reg_prd2", this);
//          cdn_ps_ahb0_reg_prd3 = uvm_reg_predictor#(denaliCdn_ahbTransaction)::type_id::create("cdn_ps_ahb0_reg_prd3", this);
         `endif // SUV_CDN_PS_AHB

          `ifdef PKC_EN
        cdn_ps_ahb_pkc_reg_prd = uvm_reg_predictor#(denaliCdn_ahbTransaction)::type_id::create("cdn_ps_ahb_pkc_reg_prd",this);
          `endif //PKC_EN
      end
      
      `ifdef SUV_CDN_PS_APB
        if(!$test$plusargs("AUTO_PREDICT")) begin
            apb0_reg_prd0 = uvm_reg_predictor#(denaliCdn_apbTransaction)::type_id::create("apb0_reg_prd0", this);
        end
      `endif // SUV_CDN_PS_APB

      `ifdef SUV_SEC_APB
   
      // ---------------------------------------------------------------
      // Construct predictor.
      // ---------------------------------------------------------------
      `ifdef SUV_SEC_APB0
      if($test$plusargs("AUTO_PREDICT")) begin
      end else begin
         sec_apb0_reg_prd = uvm_reg_predictor#(sec_apb_trans_c)::type_id::create("sec_apb0_reg_prd", this);
      end
      `endif // SUV_SEC_APB0
        
     `ifdef SUV_SEC_APB1
      if($test$plusargs("AUTO_PREDICT")) begin
      end else begin
         sec_apb1_reg_prd = uvm_reg_predictor#(sec_apb_trans_c)::type_id::create("sec_apb1_reg_prd", this);
      end
      `endif // SUV_SEC_APB1
       
      
      `endif // SUV_SEC_APB

   endfunction: build_phase

   // ---------------------------------------------------------------
   // Connect ports, handle, sequencer.
   // ---------------------------------------------------------------
   virtual function void connect_phase(uvm_phase phase);

      super.connect_phase(phase);

      `uvm_info(get_full_name(), "connect_phase() ...", UVM_FULL)

      // ---------------------------------------------------------------
      // Connect UVC sequencer to sequencer handle of virtual sequencer.
      /
// ---------------------------------------------------------------
      `ifdef SUV_CDN_PS_AXI
      `ifdef SUV_CDN_PS_AXI_IF0

      vseqr.p_cdn_ps_axi_if0_env = cdn_ps_axi_if0_env;

      if(cdn_ps_axi_if0_env.has_slave == 1)
      vseqr.p_cdn_ps_axi_if0_slave_seqr = cdn_ps_axi_if0_env.slave.sequencer;
      vseqr.p_axi_slave = cdn_ps_axi_if0_env.slave;
      `endif // SUV_CDN_PS_AXI_IF0
      `endif // SUV_CDN_PS_AXI

      `ifdef SUV_CDN_AMBA_LPI
           if (!$cast(vseqr.controllerSeqr, cdn_amba_lpi_env.activeController.sequencer)) begin
               `uvm_fatal (get_type_name(), "$cast(vseqr.controllerSeqr, cdn_amba_lpi_env.activeController.sequencer) call failed");
           end
           if (!$cast(vseqr.peripheralSeqr, cdn_amba_lpi_env.activePeripheral.sequencer)) begin
               `uvm_fatal (get_type_name(), "$cast(vseqr.peripheralSeqr, cdn_amba_lpi_env.activePeripheral.sequencer) call failed");
           end
           if (!$cast(vseqr.p_cdn_amba_lpi_env, cdn_amba_lpi_env)) begin
               `uvm_fatal (get_type_name(), "$cast(vseqr.p_cdn_amba_lpi_env, cdn_amba_lpi_env) call failed");
           end
      `endif // SUV_CDN_AMBA_LPI
//niha
    `ifdef SSC_EN
      vseqr.p_ahb_ssc_dm_seqr = cdn_ps_ahb_ssc_env.master[1].sequencer;
    vseqr.cdn_ps_ahb_ssc_env = cdn_ps_ahb_ssc_env;
    vseqr.p_ahb_ssc_pm_seqr = cdn_ps_ahb_ssc_env.master[0].sequencer;
      vseqr.p_ahb_ssc_s0_seqr = cdn_ps_ahb_ssc_env.slave[0].sequencer;
      vseqr.p_ahb_ssc_s1_seqr = cdn_ps_ahb_ssc_env.slave[1].sequencer;
  `endif
      `ifdef TRNG_EN 
      vseqr.cdn_ps_ahb_trng_env = cdn_ps_ahb_trng_env;
      `endif

      `ifdef SUV_CDN_PS_AHB // ACTIVE AGENTS
       `ifndef SSS_LITE
      vseqr.p_ahb0_m0_seqr = cdn_ps_ahb0_env.master[0].sequencer;
      vseqr.p_ahb0_s1_seqr = cdn_ps_ahb0_env.slave[1].sequencer;
      vseqr.p_ahb0_s2_seqr = cdn_ps_ahb0_env.slave[2].sequencer;
      vseqr.p_ahb0_s3_seqr = cdn_ps_ahb0_env.slave[3].sequencer;
      vseqr.p_ahb0_s4_seqr = cdn_ps_ahb0_env.slave[4].sequencer;
      vseqr.p_ahb0_m2_seqr = cdn_ps_ahb0_env.master[2].sequencer;
      vseqr.p_ahb0_m3_seqr = cdn_ps_ahb0_env.master[3].sequencer; //TBDJ
      //JEJEvseqr.p_ahb1_s0_seqr = cdn_ps_ahb0_env.slave[0].sequencer;
       `else
       //AHB0 ENV
      vseqr.p_ahb0_m0_seqr = cdn_ps_ahb0_env.master[0].sequencer;
      vseqr.p_ahb0_m1_seqr = cdn_ps_ahb0_env.master[1].sequencer;
      vseqr.p_ahb0_s0_seqr = cdn_ps_ahb0_env.slave[0].sequencer;
      vseqr.p_ahb0_s1_seqr = cdn_ps_ahb0_env.slave[1].sequencer;

    vseqr.p_ahb_ssc_pm_seqr = cdn_ps_ahb_ssc_env.master[0].sequencer;
      vseqr.p_ahb_ssc_dm_seqr = cdn_ps_ahb_ssc_env.master[1].sequencer;
      vseqr.p_ahb_ssc_s0_seqr = cdn_ps_ahb_ssc_env.slave[0].sequencer;
      vseqr.p_ahb_ssc_s1_seqr = cdn_ps_ahb_ssc_env.slave[1].sequencer;
      //AHB1 ENV
      vseqr.p_ahb1_m0_seqr = cdn_ps_ahb1_env.master[0].sequencer;      
      vseqr.p_ahb1_m1_seqr = cdn_ps_ahb1_env.master[1].sequencer;      
      vseqr.p_ahb1_m2_seqr = cdn_ps_ahb1_env.master[2].sequencer;      
      vseqr.p_ahb1_m3_seqr = cdn_ps_ahb1_env.master[3].sequencer;      
      vseqr.p_ahb1_m4_seqr = cdn_ps_ahb1_env.master[4].sequencer;      
      vseqr.p_ahb1_s0_seqr = cdn_ps_ahb1_env.slave[0].sequencer;
      vseqr.p_ahb1_s1_seqr = cdn_ps_ahb1_env.slave[1].sequencer;
      vseqr.p_ahb1_s2_seqr = cdn_ps_ahb1_env.slave[2].sequencer;
      vseqr.p_ahb1_s3_seqr = cdn_ps_ahb1_env.slave[3].sequencer;
      //vseqr.p_ahb1_s4_seqr = cdn_ps_ahb1_env.slave[4].sequencer;
      //vseqr.p_ahb1_s5_seqr = cdn_ps_ahb1_env.slave[5].sequencer;

      vseqr.cdn_ps_ahb0_env = cdn_ps_ahb0_env;
    vseqr.cdn_ps_ahb_ssc_env = cdn_ps_ahb_ssc_env;
      vseqr.cdn_ps_ahb1_env = cdn_ps_ahb1_env;
      `ifdef ARGON2_VE
      vseqr.cdn_ps_ahb_argon2_env= cdn_ps_ahb_argon2_env;
      `endif

      `ifdef PKC_VE
      vseqr.cdn_ps_ahb_pkc_env = cdn_ps_ahb_pkc_env;
      `endif //PKC_VE

       `endif //SSS_LITE
      `endif // SUV_CDN_PS_AHB
 
      `ifdef PKC_EN
      vseqr.cdn_ps_ahb_pkc_env = cdn_ps_ahb_pkc_env;
      vseqr.cdn_ps_ahb_trng_env = cdn_ps_ahb_trng_env;
      `endif //PKC_EN

      `ifdef SUV_CDN_PS_AHB // ACTIVE AGENTS
         //JEJEif(!$cast(cdn_ps_ahb0_mon_cmzp, cdn_ps_ahb0_env.master[0].monitor))    // CM0PLUS AHB Pssive Master Monitor// CM0 AHB DUT MASTER MONITOR
         //JEJE   `uvm_fatal(get_type_name(), "Fail to cast cdn_ps_ahb_env0.master[0].monitor to cdn_ps_ahb0_mon_cmzp")// CM0 AHB DUT MASTER MONITOR
        `ifndef SSS_LITE
         if(!$cast(cdn_ps_ahb0_mon_cmzs, cdn_ps_ahb0_env.slave[0].monitor))    // CM0PLUS AHB Pssive Slave Monitor
            `uvm_fatal(get_type_name(), "Fail to cast cdn_ps_ahb_env0.slave[0].monitor to cdn_ps_ahb0_mon_cmzs")
         if(!$cast(cdn_ps_ahb0_mon_sdma, cdn_ps_ahb0_env.master[1].monitor))    // SDMA AHB Pssive Master Monitor
            `uvm_fatal(get_type_name(), "Fail to cast cdn_ps_ahb_env0.master[1].monitor to cdn_ps_ahb0_mon_sdma") //TBDJ
        `endif
         //JEJEif (!$cast(vseqr.pEnv, cdn_ps_ahb0_env)) begin
         //JEJE   `uvm_fatal(get_type_name(),"$cast(vseqr.pEnv, cdn_ps_ahb_env0) call failed!");
         //JEJEend
         `



`ifndef SSP_ENVIRONMENT_SV
`define SSP_ENVIRONMENT_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "interface.sv"
`include "scoreboard.sv"
`include "agent.sv"
class ssp_environment extends uvm_env;

    `uvm_component_utils(ssp_environment)
    virtual ssp_interface  vif; 
    ssp_scoreboard  scb;
    ssp_agent       agt;

    function new(string name = "ssp_environment",uvm_component parent);
        super.new(name ,parent);
    endfunction:new

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("build phase", "Entered...", UVM_HIGH)
        if(!uvm_config_db#(virtual ssp_interface)::get(this,"","vif",vif))
        `uvm_fatal(get_type_name(),$sformatf("Failed to get from uvm_config_db"))

        scb = ssp_scoreboard::type_id::create("scb",this);
        agt = ssp_agent::type_id::create("agt",this);
        uvm_config_db#(virtual ssp_interface)::set(this,"agt","vif",vif);
        `uvm_info("build_phase", "Exiting...", UVM_HIGH) 
    endfunction : build_phase

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase (phase);
        agt.ssp_mon.mon_p.connect(scb.scoreboard_export);
    endfunction : connect_phase

endclass : ssp_environment

`endif 
`ifndef SSP_BASE_TEST_SV
`define SSP_BASE_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

// interface must be included before environment if env uses it
`include "interface.sv"
`include "environment.sv"

class ssp_base_test extends uvm_test;
    `uvm_component_utils (ssp_base_test)
    ssp_environment ssp_env;
    virtual ssp_interface vif;

    function new(string name="ssp_base_test", uvm_component parent); 
        super.new(name, parent);
    endfunction: new
    virtual function void build_phase (uvm_phase phase); 
        super.build_phase (phase); 
        `uvm_info("build_phase", "Entered...", UVM_HIGH) 
        if(!uvm_config_db#(virtual ssp_interface)::get(this, "", "vif", vif)) 
            `uvm_fatal (get_type_name(), $sformatf("Faile to get vif uvm_config_db")) 
        ssp_env = ssp_environment::type_id::create("ssp_env", this); 
        uvm_config_db#(virtual ssp_interface)::set(this, "ssp_env", "vif", vif); 
        `uvm_info("build_phase", "Exiting...", UVM_HIGH)
    endfunction: build_phase
    
    virtual function void start_of_simulation_phase (uvm_phase phase);
        `uvm_info("start_of_simulation_phase", "Entered...", UVM_HIGH)
            uvm_top.print_topology(); 
        `uvm_info("start_of_simulation_phase", "Exiting...", UVM_HIGH)
    endfunction : start_of_simulation_phase

endclass
`endif

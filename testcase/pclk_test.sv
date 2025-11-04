`ifndef SSP_PCLK_TEST_SV
`define SSP_PCLK_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "pclk_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"

class pclk_test extends ssp_base_test;
    `uvm_component_utils (pclk_test)

    pclk_test_sequence pclk_test;

    function new(string name = "pclk_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        pclk_test = pclk_test_sequence::type_id::create("pclk_test");
        

        pclk_test.start(ssp_env.agt.ssp_seq);
        phase.drop_objection(this);
        
    endtask
endclass : pclk_test

`endif

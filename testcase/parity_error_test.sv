`timescale 1ns/1ps
`ifndef SSP_PARITY_ERROR_TEST_SV
`define SSP_PARITY_ERROR_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "parity_error_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"
`include "interface.sv"

class parity_error_test extends ssp_base_test;
    `uvm_component_utils (parity_error_test)

    parity_error_test_sequence parity_error_test;


    function new(string name = "parity_error_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        parity_error_test = parity_error_test_sequence::type_id::create("parity_error_test");

            parity_error_test.start(ssp_env.agt.ssp_seq);
        
        phase.drop_objection(this);
        
    endtask

endclass : parity_error_test

`endif

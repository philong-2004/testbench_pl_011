`timescale 1ns/1ps
`ifndef SSP_SIR_EN_TEST_SV
`define SSP_SIR_EN_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "sir_en_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"
`include "interface.sv"

class sir_en_test extends ssp_base_test;
    `uvm_component_utils (sir_en_test)

    sir_en_test_sequence sir_en_test;



    function new(string name = "sir_en_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        sir_en_test = sir_en_test_sequence::type_id::create("sir_en_test");
        sir_en_test.start(ssp_env.agt.ssp_seq);
        #1000;
        phase.drop_objection(this);
        
    endtask

endclass : sir_en_test

`endif

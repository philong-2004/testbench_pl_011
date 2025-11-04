`timescale 1ns/1ps
`ifndef SSP_RESET_TEST_SV
`define SSP_RESET_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "reset_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"
`include "interface.sv"

class reset_test extends ssp_base_test;
    `uvm_component_utils (reset_test)

    reset_test_sequence reset_test;



    function new(string name = "reset_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        reset_test = reset_test_sequence::type_id::create("reset_test");
        fork
        reset_test.start(ssp_env.agt.ssp_seq);
            vif.PRESETn = 1;
            vif.nUARTRST = 1;
            #200 begin
            vif.PRESETn = 0;
            vif.nUARTRST = 0;
            end
            #100 begin
            vif.PRESETn = 1;
            vif.nUARTRST = 1;
            end
        join

        
        phase.drop_objection(this);
        
    endtask

endclass : reset_test

`endif

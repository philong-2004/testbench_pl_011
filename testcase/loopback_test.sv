`timescale 1ns/1ps
`ifndef SSP_LOOPBACK_TEST_SV
`define SSP_LOOPBACK_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "loopback_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"
`include "interface.sv"

class loopback_test extends ssp_base_test;
    `uvm_component_utils (loopback_test)

    loopback_test_sequence loopback_test;
    ssp_interface vif;


    function new(string name = "loopback_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        loopback_test = loopback_test_sequence::type_id::create("loopback_test");

        fork
            uart_clk_test.start(ssp_env.agt.ssp_seq);
            begin
                vif.PSEL = 1;
                vif.PENABLE = 1;
            end
        join
        
        phase.drop_objection(this);
        
    endtask

endclass : loopback_test

`endif

`timescale 1ns/1ps
`ifndef SSP_BAUD_GEN_TEST_SV
`define SSP_BAUD_GEN_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "baud_gen_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"
`include "interface.sv"

class baud_gen_test extends ssp_base_test;
    `uvm_component_utils (baud_gen_test)

    baud_gen_test_sequence baud_gen_test;
    ssp_interface vif;


    function new(string name = "baud_gen_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        baud_gen_test = baud_gen_test_sequence::type_id::create("baud_gen_test");

        fork
            uart_clk_test.start(ssp_env.agt.ssp_seq);
            begin
                vif.PSEL = 1;
                vif.PENABLE = 1;
                vif.UARTCLK = 0;
                vif.PCLK = 0
                forever begin
                    #200 vif.PCLK = ~vif.PCLK;
                    #250 vif.UARTCLK = ~vif.UARTCLK; // tạo UARTCLK = 4MHz
                    end 
                end
        join
        
        phase.drop_objection(this);
        
    endtask

endclass : baud_gen_test

`endif

`timescale 1ns/1ps
`ifndef SSP_LOWPWR_IRDA_TEST_SV
`define SSP_LOWPWR_IRDA_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "lowpwr_irDA_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"
`include "interface.sv"

class lowpwr_irDA_test extends ssp_base_test;
    `uvm_component_utils (lowpwr_irDA_test)

    lowpwr_irDA_test_sequence lowpwr_irDA_test;



    function new(string name = "lowpwr_irDA_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        lowpwr_irDA_test = lowpwr_irDA_test_sequence::type_id::create("lowpwr_irDA_test");

        fork
            lowpwr_irDA_test.start(ssp_env.agt.ssp_seq);
            begin
                vif.UARTCLK = 0;
                vif.PCLK = 0;
                repeat(200) begin
                    #400 vif.PCLK = ~vif.PCLK;
                    #250 vif.UARTCLK = ~vif.UARTCLK; // tạo UARTCLK = 4MHz, 
                end
            end
        join
        
        phase.drop_objection(this);
        
    endtask

endclass : lowpwr_irDA_test

`endif

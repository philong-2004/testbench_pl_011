`timescale 1ns/1ps
`ifndef SSP_FREQ_RATIO_TEST_SV
`define SSP_FREQ_RATIO_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "freq_ratio_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"
`include "interface.sv"

class freq_ratio_test extends ssp_base_test;
    `uvm_component_utils (freq_ratio_test)

    freq_ratio_test_sequence freq_ratio_test;
    ssp_interface vif;


    function new(string name = "freq_ratio_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        freq_ratio_test = freq_ratio_test_sequence::type_id::create("freq_ratio_test");

        fork
            uart_clk_test.start(ssp_env.agt.ssp_seq);
            begin
                vif.PSEL = 1;
                vif.PENABLE = 1;
                vif.UARTCLK = 0;
                vif.PCLK = 0
                forever begin
                    repeat(1000) begin
                    #20 vif.PCLK = ~vif.PCLK;
                    #10 vif.UARTCLK = ~vif.UARTCLK; 
                    end //UARTCLK <= (5/3)PCLK <= 12ns
                    //sau 1000 chu ky thì đổi tỷ lệ clock
                    repeat(1000) begin
                    #20 vif.PCLK = ~vif.PCLK;
                    #20 vif.UARTCLK = ~vif.UARTCLK;
                    end //UARTCLK > (5/3) PCLK > 12ns
                end
                

            end
        join
        
        phase.drop_objection(this);
        
    endtask

endclass : freq_ratio_test

`endif

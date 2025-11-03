`timescale 1ns/1ps
`ifndef SSP_UART_STOP_CLK_TEST_SV
`define SSP_UART_STOP_CLK_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "uart_stop_clk_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"
`include "interface.sv"

class uart_stop_clk_test extends ssp_base_test;
    `uvm_component_utils (uart_stop_clk_test)

    uart_stop_clk_test_sequence uart_stop_clk_test;
    ssp_interface vif;


    function new(string name = "uart_stop_clk_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        uart_stop_clk_test = uart_stop_clk_test_sequence::type_id::create("uart_stop_clk_test");

        fork
            uart_clk_test.start(ssp_env.agt.ssp_seq);
            begin
                vif.PSEL = 1;
                vif.PENABLE = 1;
                vif.UARTCLK = 0;
                vif.PCLK = 0
                forever begin
                    repeat(1000) begin
                    #10 vif.UARTCLK = ~vif.UARTCLK; 
                    end
                    //sau 1000 chu ky thì đổi clock
                    
                    #1000 vif.UARTCLK = 0;
                    
                    //UARTCLK = 0 trong 1000ns
                end
                

            end
        join
        
        phase.drop_objection(this);
        
    endtask

endclass : uart_stop_clk_test

`endif

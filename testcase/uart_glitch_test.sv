`timescale 1ns/1ps
`ifndef SSP_UART_GLITCH_TEST_SV
`define SSP_UART_GLITCH_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "uart_glitch_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"
`include "interface.sv"

class uart_glitch_test extends ssp_base_test;
    `uvm_component_utils(uart_glitch_test)

    uart_glitch_test_sequence uart_glitch_test;



    function new(string name = "uart_glitch_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        uart_glitch_test = uart_glitch_test_sequence::type_id::create("uart_glitch_test");

        fork
            uart_glitch_test.start(ssp_env.agt.ssp_seq);
            begin
                    vif.UARTCLK = 0;
                    repeat(1000) begin
                    #10 vif.UARTCLK = ~vif.UARTCLK;
                    end
                    #(5 + $urandom_range(0, 10)); vif.UARTCLK = ~vif.UARTCLK; 
                    //sau 1000 chu ky thi tao 1 glitch

            end
        join
        
        phase.drop_objection(this);
        
    endtask

endclass : uart_glitch_test

`endif

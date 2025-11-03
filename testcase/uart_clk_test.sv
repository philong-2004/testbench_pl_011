`ifndef SSP_UART_CLK_TEST_SV
`define SSP_UART_CLK_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "uart_clk_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"

class uart_clk_test extends ssp_base_test;
    `uvm_component_utils (uart_clk_test)

    uart_clk_test_sequence uart_clk_test;

    function new(string name = "uart_clk_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        uart_clk_test = uart_clk_test_sequence::type_id::create("uart_clk_test");

        fork
            uart_clk_test.start(ssp_env.agt.ssp_seq);
            begin
                vif.UARTCLK = 0;
                #1000;
                `uvm_info(get_type_name(), $sformatf("UARTCLK = 50 MHz", UVM_LOW));
                repeat(1000) #20 vif.UARTCLK = ~vif.UARTCLK;
                #1000;
                `uvm_info(get_type_name(), $sformatf("UARTCLK = 25 MHz", UVM_LOW));
                repeat(1000) #40 vif.UARTCLK = ~vif.UARTCLK;
                #1000;
                `uvm_info(get_type_name(), $sformatf("UARTCLK = 100 MHz", UVM_LOW));
                repeat(1000) #10 vif.UARTCLK = ~vif.UARTCLK;
                #1000;
                `uvm_info(get_type_name(), $sformatf("UARTCLK = 10 MHz", UVM_LOW));
                repeat(1000) #100 vif.UARTCLK = ~vif.UARTCLK;
            end
        join


        
        phase.drop_objection(this);
        
    endtask
endclass : uart_clk_test

`endif

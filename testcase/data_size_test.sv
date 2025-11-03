`timescale 1ns/1ps
`ifndef SSP_DATA_SIZE_TEST_SV
`define SSP_DATA_SIZE_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "data_size_test_sequence.sv"
`include "base_test.sv"
`include "environment.sv"
`include "agent.sv"
`include "interface.sv"

class data_size_test extends ssp_base_test;
    `uvm_component_utils (data_size_test)

    data_size_test_sequence data_size_test;
    ssp_interface vif;


    function new(string name = "data_size_test",uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        data_size_test = data_size_test_sequence::type_id::create("data_size_test");

        fork
            uart_clk_test.start(ssp_env.agt.ssp_seq);
            begin
                vif.PSEL = 1;
                vif.PENABLE = 1;
            end
        join
        
        phase.drop_objection(this);
        
    endtask

endclass : data_size_test

`endif

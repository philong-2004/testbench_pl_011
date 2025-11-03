`ifndef SSP_UART_CLK_TEST_SEQUENCE_SV
`define SSP_UART_CLK_TEST_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "sequencer.sv"
`include "transaction.sv"
class uart_clk_test_sequence extends uvm_sequence#(ssp_transaction);
    `uvm_object_utils(uart_clk_test_sequence);
    ssp_transaction rq;

    function new(string name ="uart_clk_test_sequence");
        super.new(name);
    endfunction

    virtual task body ();
        bit [15:0]w_data;
        bit [11:0] addr_rand;
        rq = ssp_transaction::type_id::create("rq");
        start_item(rq);
        addr_rand = 12'd028; //address register UARTBAUD

        rq =  ssp_transaction::type_id::create("rq");
            start_item(rq);
            mode_r_w = ssp_transaction::READ;
            addr = addr_rand;
            w_data = data;
                //data == 0;

        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        finish_item(rq);
        get_response(rsp);
        if (rsp.data >= 110 && rsp.data <= 460800 ) begin //example UARTCLK between 7.3728 MHz - 115.34 MHz
            `uvm_info(get_type_name(), $sformatf("Frequence of UARTCLK is valid"), UVM_LOW);
         end else
            `uvm_error(get_type_name(), $sformatf ("Frequence of UARTCLK isn't corresponding to Spec"))

        `uvm_info(get_type_name(), $sformatf ("Recevied rsp: \n %s", rsp.sprint()),UVM_LOW);

    endtask

endclass : uart_clk_test_sequence

`endif

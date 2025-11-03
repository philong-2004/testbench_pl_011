`ifndef SSP_PCLK_TEST_SEQUENCE_SV
`define SSP_PCLK_TEST_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "sequencer.sv"
`include "transaction.sv"
class pclk_test_sequence extends uvm_sequence#(ssp_transaction);
    `uvm_object_utils(pclk_test_sequence);
    ssp_transaction rq;

    function new(string name ="pclk_test_sequence");
        super.new(name);
        
    endfunction

    virtual task body ();
        bit [15:0]w_data;
        bit [11:0] addr_rand;
        rq = ssp_transaction::type_id::create("rq");
        start_item(rq);
        w_data = $random;
        addr_rand = $random;
        rq.randomize() with{
            mode_r_w == ssp_transaction::WRITE;
            addr == addr_rand;
            data == w_data;
        };
        `uvm_info (get_type_name(),$sformatf("Send to driver packet : \n %0s",rq.sprint()),UVM_LOW)
        finish_item(rq);
        get_response(rsp);

        rq =  ssp_transaction::type_id::create("rq");
            start_item(rq);
            
                rq.mode_r_w = ssp_transaction::READ;
                rq.addr = addr_rand;
                //data == 0;


        `uvm_info (get_type_name(),$sformatf("Send to driver packet : \n %0s",rq.sprint()),UVM_LOW)
        finish_item(rq);
        get_response(rsp);

        `uvm_info(get_type_name(), $sformatf ("Recevied rsp to driver: \n %s", rsp.sprint()),UVM_LOW);

    endtask

endclass : pclk_test_sequence

`endif

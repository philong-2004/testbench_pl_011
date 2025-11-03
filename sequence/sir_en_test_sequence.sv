`ifndef SSP_SIR_EN_TEST_SEQUENCE_SV
`define SSP_SIR_EN_TEST_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "sequencer.sv"
`include "transaction.sv"

class sir_en_test_sequence extends uvm_sequence#(ssp_transaction);
    `uvm_object_utils(sir_en_test_sequence);
    ssp_transaction rq;

    function new(string name ="sir_en_test_sequence");
        super.new(name);
    endfunction

    virtual task body ();
        bit [15:0]w_data;
        bit [11:0] addr_rand;
        bit [15:0] random_data;
        random_data = $urandom_range(0, 255);
        
        rq = ssp_transaction::type_id::create("rq");
        start_item(rq);
        //Set up data truyền đi, ghi vào UARTDR
        write_data(random_data,12'h000); 
        //ghi giá trị vào thanh ghi UARTCR
        write_data(16'b1000111110000010, 12'h030); //addr UARTCR = 0x030
        //UARTCR[1] = 1 => SIR enable
        //bật bit UARTCR[7] Loop back Enable = 1

        //cấu hình data transmit trên UARTLCR_H
        write_data(16'b0000000001100000, 12'h02c);
        //UARTLCR_H[6:5] = 11, data có 8 bit

        //Bật DMA TXD để ghi data vào nSIROUT
        write_data(16'b0000000000000010,12'h048); 
        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        finish_item(rq);
        get_response(rsp);

        write_data(16'b0000000000000001,12'h048);//Bật DMA SIRIN để nhận data từ nSIROUT
        rq =  ssp_transaction::type_id::create("rq"); //doc lai data đã Write
        rq.randomize() with{
            start_item(rq);
            mode_r_w ==  ssp_transaction::READ;
            addr == 12'h000;        
            };
            //Đọc lại data nhận từ RXD do TXD truyền đến

        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        finish_item(rq);
        get_response(rsp);
        if (rsp.data == random_data ) begin //compare data send vs data response
            `uvm_info(get_type_name(), $sformatf("Pass SIR Test."), UVM_LOW);
         end else
            `uvm_error(get_type_name(), $sformatf ("Failed SIR Test. Data recived: %h, Expect: %h", rsp.data, random_data))

        `uvm_info(get_type_name(), $sformatf ("Recevied rsp: \n %s", rsp.sprint()),UVM_LOW);

    endtask


    task write_data(w_data, addr_rand);
        bit [15:0]w_data;
        bit [11:0] addr_rand;

        rq.randomize() with{
            mode_r_w == ssp_transaction::WRITE;
            addr == addr_rand;
            data == w_data;
        };
    endtask
endclass : sir_en_test_sequence

`endif

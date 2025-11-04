`ifndef SSP_DATA_SIZE_TEST_SEQUENCE_SV
`define SSP_DATA_SIZE_TEST_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "sequencer.sv"
`include "transaction.sv"

class data_size_test_sequence extends uvm_sequence#(ssp_transaction);
    `uvm_object_utils(data_size_test_sequence);
    ssp_transaction rq;

    function new(string name ="data_size_test_sequence");
        super.new(name);
    endfunction

    virtual task body ();
        bit [15:0]w_data;
        bit [11:0] addr_rand;
        bit [15:0] random_data;
        random_data = $urandom_range(0, 255);
        //------------- Word Length = 8 -------------
        //Set up data truyền đi, ghi vào UARTDR

        write_data(random_data,12'h000); 
        //ghi giá trị vào thanh ghi UARTCR, bật bit UARTCR[7] Loop back Enable = 1

        write_data(16'b1000111110000001, 12'h030);
        //cấu hình data transmit trên UARTTXD 

        write_data(16'b0000000001100000, 12'h02c);
        //UARTLCR_H[6,5] = 11 => WLEN = 8 bits

        //Bật DMA TXD để ghi data vào UART TXD
        write_data(16'b0000000000000010,12'h048); 
        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        get_response(rsp);

        write_data(16'b0000000000000001,12'h048);//Bật DMA RXD để nhận data từ UART RXD
        rq =  ssp_transaction::type_id::create("rq"); //doc lai data đã Write
        start_item(rq);
        rq.randomize() with{
            mode_r_w ==  ssp_transaction::READ;
            addr == 12'h000;        
            };
            //Đọc lại data nhận từ RXD do TXD truyền đến

        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        finish_item(rq);
        get_response(rsp);
        if (rsp.data == random_data ) begin //compare data send vs data response
            `uvm_info(get_type_name(), $sformatf("Pass Loop Back Test."), UVM_LOW);
         end else
            `uvm_error(get_type_name(), $sformatf ("Failed Loop Back Test. Data recived: %h, Expect: %h", rsp.data, random_data))

//---------------------------------------------------------------------------------------------------//    

    random_data = $urandom_range(0, 128);
        //------------- Word Length = 7 -------------
        //Set up data truyền đi, ghi vào UARTDR

        write_data(random_data,12'h000); 
        //ghi giá trị vào thanh ghi UARTCR, bật bit UARTCR[7] Loop back Enable = 1

        write_data(16'b1000111110000001, 12'h030);
        //cấu hình data transmit trên UARTTXD 

        write_data(16'b0000000001000000, 12'h02c);
        //UARTLCR_H[6,5] = 10 => WLEN = 7 bits

        //Bật DMA TXD để ghi data vào UART TXD
        write_data(16'b0000000000000010,12'h048); 
        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        get_response(rsp);

        write_data(16'b0000000000000001,12'h048);//Bật DMA RXD để nhận data từ UART RXD
        rq =  ssp_transaction::type_id::create("rq"); //doc lai data đã Write
        start_item(rq);
        rq.randomize() with{
            mode_r_w ==  ssp_transaction::READ;
            addr == 12'h000;        
            };
            //Đọc lại data nhận từ RXD do TXD truyền đến

        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        finish_item(rq);
        get_response(rsp);
        if (rsp.data == random_data ) begin //compare data send vs data response
            `uvm_info(get_type_name(), $sformatf("Pass Loop Back Test."), UVM_LOW);
         end else
            `uvm_error(get_type_name(), $sformatf ("Failed Loop Back Test. Data recived: %h, Expect: %h", rsp.data, random_data))           

//---------------------------------------------------------------------------------------------------//    

    random_data = $urandom_range(0, 64);
        //------------- Word Length = 6 -------------
        //Set up data truyền đi, ghi vào UARTDR

        write_data(random_data,12'h000); 
        //ghi giá trị vào thanh ghi UARTCR, bật bit UARTCR[7] Loop back Enable = 1

        write_data(16'b1000111110000001, 12'h030);
        //cấu hình data transmit trên UARTTXD 

        write_data(16'b0000000000100000, 12'h02c);
        //UARTLCR_H[6,5] = 01 => WLEN = 6 bits

        //Bật DMA TXD để ghi data vào UART TXD
        write_data(16'b0000000000000010,12'h048); 
        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        get_response(rsp);

        write_data(16'b0000000000000001,12'h048);//Bật DMA RXD để nhận data từ UART RXD
        rq =  ssp_transaction::type_id::create("rq"); //doc lai data đã Write
        start_item(rq);
        rq.randomize() with{
            mode_r_w ==  ssp_transaction::READ;
            addr == 12'h000;        
            };
            //Đọc lại data nhận từ RXD do TXD truyền đến

        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        finish_item(rq);
        get_response(rsp);
        if (rsp.data == random_data ) begin //compare data send vs data response
            `uvm_info(get_type_name(), $sformatf("Pass Loop Back Test."), UVM_LOW);
         end else
            `uvm_error(get_type_name(), $sformatf ("Failed Loop Back Test. Data recived: %h, Expect: %h", rsp.data, random_data))         
         
//---------------------------------------------------------------------------------------------------//         
    random_data = $urandom_range(0, 32);
        //------------- Word Length = 5 -------------
        //Set up data truyền đi, ghi vào UARTDR

        write_data(random_data,12'h000); 
        //ghi giá trị vào thanh ghi UARTCR, bật bit UARTCR[7] Loop back Enable = 1

        write_data(16'b1000111110000001, 12'h030);
        //cấu hình data transmit trên UARTTXD 

        write_data(16'b0000000000000000, 12'h02c);
        //UARTLCR_H[6,5] = 00 => WLEN = 5 bits

        //Bật DMA TXD để ghi data vào UART TXD
        write_data(16'b0000000000000010,12'h048); 
        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        get_response(rsp);

        write_data(16'b0000000000000001,12'h048);//Bật DMA RXD để nhận data từ UART RXD
        rq =  ssp_transaction::type_id::create("rq"); //doc lai data đã Write
        start_item(rq);
        rq.randomize() with{
            mode_r_w ==  ssp_transaction::READ;
            addr == 12'h000;        
            };
            //Đọc lại data nhận từ RXD do TXD truyền đến

        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        finish_item(rq);
        get_response(rsp);
        if (rsp.data == random_data ) begin //compare data send vs data response
            `uvm_info(get_type_name(), $sformatf("Pass Loop Back Test."), UVM_LOW);
         end else
            `uvm_error(get_type_name(), $sformatf ("Failed Loop Back Test. Data recived: %h, Expect: %h", rsp.data, random_data))


         
        `uvm_info(get_type_name(), $sformatf ("Recevied rsp: \n %s", rsp.sprint()),UVM_LOW);

    endtask


    task write_data(w_data, addr_rand);
        bit [15:0]w_data;
        bit [11:0] addr_rand;
        rq = ssp_transaction::type_id::create("rq");
        start_item(rq);
        rq.randomize() with{
            
            mode_r_w == ssp_transaction::WRITE;
            addr == addr_rand;
            data == w_data;
        };
        finish_item(rq);
    endtask
endclass : data_size_test_sequence

`endif

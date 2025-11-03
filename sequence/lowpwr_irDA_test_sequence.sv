`ifndef SSP_LOWPWR_IRDA_TEST_SEQUENCE_SV
`define SSP_LOWPWR_IRDA_TEST_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "sequencer.sv"
`include "transaction.sv"

class lowpwr_irDA_test_sequence extends uvm_sequence#(ssp_transaction);
    `uvm_object_utils(lowpwr_irDA_test_sequence);
    ssp_transaction rq;

    function new(string name ="lowpwr_irDA_test_sequence");
        super.new(name); 
    endfunction

    virtual task body ();
        bit [15:0]w_data;
        bit [11:0] addr_rand;
        bit [15:0] random_data;
        random_data = $urandom_range(0, 255);
        
        rq = ssp_transaction::type_id::create("rq");
        start_item(rq);

        write_data(16'd1,12'h024); //set value cho thanh ghi UARTIBRD = 1       
        write_data(6'b000100,12'h028); //set value cho thanh ghi UARTFBRD = 5 
        //ta có UARTIBRD + UARTFBRD = 1 + (5/64) = 1.078
        //F_UARTCLK = 4MHz => Baudrate được tạo ra = (4x10^6)/(16x1.078) = 231910 = 230400

        write_data(8'd4,12'h020); //addr UARTILPR = 0x020
        //ghi vào UARTILPR = 4 => ta có hệ số chia ILPDVSR = 4 = F_UARTCLK/F_irLPBaud16
        // => F_irLPBaud16 = 4MHz/4 = 1MHz

        //Set up data truyền đi, ghi vào UARTDR
        write_data(random_data,12'h000); 
        //ghi giá trị vào thanh ghi UARTCR, bật bit UARTCR[7] Loop back Enable = 1
        write_data(16'b1000111110000100, 12'h030);
        //UARTCR[2] = 1 => SIR_LowPower enable

        //cấu hình data transmit trên UARTTXD  trên thanh ghi UARCLR_H
        write_data(16'b0000000001100000, 12'h02c);
        //UARTLCR_H[6:5] = 11, data có 8 bit

        //Bật DMA TXD để ghi data vào nSIROUT
        write_data(16'b0000000000000010,12'h048);  
        `uvm_info (get_type_name(),$sformatf("Sending packet... : \n %0s",rq.sprint()),UVM_LOW)
        finish_item(rq);
        get_response(rsp);

        write_data(16'b0000000000000001,12'h048);//Bật DMA RXD để nhận data từ UART RXD
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
            `uvm_info(get_type_name(), $sformatf("SIR_LP done! You can simulate to check pulse width Data"), UVM_LOW);
         end else
            `uvm_error(get_type_name(), $sformatf ("SIR_LP Failed"))

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
endclass : lowpwr_irDA_test_sequence

`endif

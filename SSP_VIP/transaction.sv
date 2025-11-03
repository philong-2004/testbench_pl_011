`ifndef SSP_TRANSACTION_SV
`define SSP_TRANSACTION_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
class ssp_transaction extends uvm_sequence_item;
    typedef enum bit { WRITE = 1 , READ = 0} transfer;
    rand transfer mode_r_w;
    rand bit [11:0] addr;
    rand bit [15:0] data;
    
    bit        [15:0] UARTRXD;
    bit        [15:0] UARTTXD;

    `uvm_object_utils_begin (ssp_transaction)
        `uvm_field_enum (transfer,mode_r_w           ,UVM_ALL_ON|UVM_HEX )
        `uvm_field_int (addr                    ,UVM_ALL_ON|UVM_HEX)
        `uvm_field_int (data                    ,UVM_ALL_ON|UVM_HEX)
        `uvm_field_int (UARTRXD                  ,UVM_ALL_ON|UVM_HEX)
        `uvm_field_int (UARTTXD                  ,UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end
    function new(string name = "ssp_transaction");
        super.new(name);
    endfunction : new
endclass : ssp_transaction
`endif 
`ifndef SSP_DRIVER_SV
`define SSP_DRIVER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "interface.sv"
`include "transaction.sv"

class ssp_driver extends uvm_driver #(ssp_transaction) ;

    `uvm_component_utils(ssp_driver) 
    virtual ssp_interface vif; 

    function new(string name = "ssp_driver", uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(virtual ssp_interface)::get(this,"","vif",vif))

        `uvm_fatal(get_type_name(),$sformatf("Failed to get from uvm_config_db"))

    endfunction:build_phase  

    virtual task run_phase(uvm_phase phase);
        ssp_transaction rq;
        wait (vif.PRESETn == 1'b1);
        forever begin
            wait (vif.PRESETn == 1'b1);
            seq_item_port.get_next_item(rq);
            driver(rq);
            $cast(rsp,rq.clone());
            rsp.set_id_info(rq);
            seq_item_port.put(rsp);
            seq_item_port.item_done();
        end
    endtask:run_phase
    task driver (inout ssp_transaction trans);
        @(posedge vif.PCLK);
        vif.PADDR   <= trans.addr;
        vif.PWRITE  <= trans.mode_r_w;
        vif.PSEL    <= 1'b1;
        vif.PENABLE <= 1'b0;
        if (trans.mode_r_w == ssp_transaction::WRITE) begin
            vif.PWDATA <= trans.data;
        end
        
        @(posedge vif.PCLK);
        vif.PENABLE <= 1'b1;
        if (trans.mode_r_w == ssp_transaction::READ) begin
              trans.data <= vif.PRDATA ;
        end

        @(posedge vif.PCLK);
        vif.PSEL    <= 1'b0;
        vif.PENABLE <= 1'b0;
        vif.PADDR   <= 'z;
        vif.PRDATA  <= '0;
        vif.PWDATA  <= '0;
        vif.PWRITE  <= 1'b0;
    endtask

endclass : ssp_driver

`endif 
`ifndef UART_MONITOR_SV
`define UART_MONITOR_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "interface.sv"
`include "transaction.sv"

class ssp_monitor extends uvm_monitor;
    `uvm_component_utils(ssp_monitor)
    virtual ssp_interface vif;
    uvm_analysis_port #(ssp_transaction) mon_p;
    bit ssp_enable;

    function new (string name = "ssp_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_p = new("mon_p", this);
        if (!uvm_config_db#(virtual ssp_interface)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Failed to get vif from config_db")
    endfunction
    virtual task run_phase(uvm_phase phase);
        wait (vif.PRESETn == 1);
        fork
            apb_register();
        join_none
    endtask

    task apb_register();
        forever begin
            ssp_transaction trans;
            trans = ssp_transaction::type_id::create("trans", this);
            @(posedge vif.PCLK);
            if (vif.PSEL && vif.PENABLE) begin
                trans.addr = vif.PADDR;
                $cast(trans.mode_r_w, vif.PWRITE);
                if(vif.PWRITE == 1)begin
                    trans.data = vif.PWDATA;
                end
            @(posedge vif.PCLK); #1ps;
            if (vif.PWRITE == 0) begin
                trans.data = vif.PRDATA;
            end
            `uvm_info(get_type_name(),$sformatf("Observed transaction : \n %s",trans.sprint()),UVM_LOW)
            mon_p.write(trans);
            end
        end
    endtask 
endclass
    
`endif

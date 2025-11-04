`ifndef SSP_AGENT_SV
`define SSP_AGENT_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "driver.sv"
`include "sequencer.sv"
`include "monitor.sv"

class ssp_agent extends uvm_agent;

    `uvm_component_utils(ssp_agent)

    ssp_sequencer   ssp_seq;
    ssp_driver      ssp_drv;
    ssp_monitor     ssp_mon;
    
    virtual ssp_interface vif;
    function new(string name = "ssp_agent", uvm_component parent);
        super.new(name,parent);
    endfunction:new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual ssp_interface)::get(this,"","vif",vif))
        `uvm_fatal(get_type_name(),$sformatf("Can't get vif from uvm_config_db"))

        if (is_active == UVM_ACTIVE) begin
            `uvm_info(get_type_name(), $sformatf ("Active agent"), UVM_LOW)
            ssp_seq = ssp_sequencer::type_id::create("ssp_seq",this);
            ssp_drv = ssp_driver::type_id::create("ssp_drv",this);
            ssp_mon = ssp_monitor::type_id::create("ssp_mon",this);
            uvm_config_db#(virtual ssp_interface)::set(this,"ssp_drv","vif",vif);
            uvm_config_db#(virtual ssp_interface)::set(this,"ssp_mon","vif",vif);
        end 
        
        else begin 
            `uvm_info(get_type_name(), $sformatf("Passive agent"), UVM_LOW)
            ssp_mon = ssp_monitor::type_id::create("ssp_mon",this);
            uvm_config_db#(virtual ssp_interface)::set(this,"ssp_mon","vif",vif);
        end

    endfunction:build_phase


    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
       if (is_active == UVM_ACTIVE) begin

            if (ssp_drv != null && ssp_seq != null) begin

                ssp_drv.seq_item_port.connect(ssp_seq.seq_item_export);
            end else begin
                `uvm_warning(get_type_name(), "null value")
            end
        end
        
    endfunction: connect_phase    


endclass : ssp_agent

`endif

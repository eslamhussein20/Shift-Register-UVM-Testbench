package shift_reg_monitor_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import shift_reg_seq_item_pkg::* ;
	import shift_reg_config_pkg::*;


	class shift_reg_monitor extends uvm_env ;
		`uvm_component_utils(shift_reg_monitor)

		shift_reg_seq_item resp_seq_item ;
		virtual shift_reg_if shift_reg_vif;
		uvm_analysis_port #(shift_reg_seq_item) mon_ap ;

		function new (string name = "shift_reg_monitor",uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase (uvm_phase phase);
			super.build_phase(phase);
			mon_ap =new("mon_ap",this);
		endfunction

		function void connect_phase (uvm_phase phase);
			super.connect_phase(phase);
		endfunction

		task run_phase (uvm_phase phase);
			super.run_phase(phase);
				forever
					begin
						resp_seq_item = shift_reg_seq_item::type_id::create("resp_seq_item");
						@(negedge shift_reg_vif.clk);
						resp_seq_item.reset = shift_reg_vif.reset ;
						resp_seq_item.serial_in = shift_reg_vif.serial_in ;
						resp_seq_item.direction = shift_reg_vif.direction ;
						resp_seq_item.mode = shift_reg_vif.mode ;
						resp_seq_item.datain = shift_reg_vif.datain ;
						resp_seq_item.dataout = shift_reg_vif.dataout ;
						mon_ap.write(resp_seq_item);
						`uvm_info("Monitor",resp_seq_item.convert2string(),UVM_LOW)
					end
		endtask : run_phase

	endclass


endpackage : shift_reg_monitor_pkg
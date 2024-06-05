package shift_reg_driver_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import shift_reg_seq_item_pkg::* ;
	import shift_reg_config_pkg::*;


	class shift_reg_driver extends uvm_driver #(shift_reg_seq_item) ;
		`uvm_component_utils(shift_reg_driver)

		shift_reg_seq_item stim_seq_item ;
		virtual shift_reg_if shift_reg_vif;
		function new (string name = "shift_reg_driver",uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase (uvm_phase phase);
			super.build_phase(phase);
		endfunction


		task run_phase (uvm_phase phase);
			super.run_phase(phase);
			forever
				begin
					stim_seq_item = shift_reg_seq_item::type_id::create("stim_seq_item");
					seq_item_port.get_next_item(stim_seq_item);
					shift_reg_vif.reset = stim_seq_item.reset ;
					shift_reg_vif.serial_in = stim_seq_item.serial_in ;
					shift_reg_vif.direction = stim_seq_item.direction ;
					shift_reg_vif.mode = stim_seq_item.mode ;
					shift_reg_vif.datain = stim_seq_item.datain ;
					@(negedge shift_reg_vif.clk);
					seq_item_port.item_done();
						`uvm_info("Driver",stim_seq_item.convert2string_stimulus(),UVM_LOW)
				end
		endtask : run_phase

	endclass


endpackage : shift_reg_driver_pkg
package shift_reg_scoreboard_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import shift_reg_seq_item_pkg::* ;
	import shift_reg_config_pkg::*;


	class shift_reg_scoreboard extends uvm_scoreboard ;
		`uvm_component_utils(shift_reg_scoreboard)

		shift_reg_seq_item seq_item_sb ;
		uvm_analysis_export #(shift_reg_seq_item) sb_export ;
		uvm_tlm_analysis_fifo #(shift_reg_seq_item) sb_fifo ;
		logic [5:0] data_out_ref ;
		function new (string name = "shift_reg_scoreboard",uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase (uvm_phase phase);
			super.build_phase(phase);
			sb_export = new("sb_export",this);
			sb_fifo = new("sb_fifo",this);
		endfunction

		function void connect_phase (uvm_phase phase);
			super.connect_phase(phase);
			sb_export.connect(sb_fifo.analysis_export);
		endfunction

		task run_phase (uvm_phase phase);
			super.run_phase(phase);
			forever
				begin
					sb_fifo.get(seq_item_sb);
					`uvm_info("SB",seq_item_sb.convert2string(),UVM_LOW)
					ref_model(seq_item_sb);
					 if (data_out_ref == seq_item_sb.dataout) 
					 	begin
					 		`uvm_info("UVM_SB","PASS",UVM_LOW);
					 	end
  				     else
					 	begin
					 		`uvm_error("UVM_SB","FAIL");
					 	end						 
				end
		endtask : run_phase

		task ref_model (shift_reg_seq_item item);
			if (item.reset)
				data_out_ref = 0 ;
  			else
  				 begin
  				    if (item.mode) // rotate
  				       if (item.direction) // left
  				          data_out_ref = {item.datain[4:0], item.datain[5]};
  				       else
  				          data_out_ref = {item.datain[0], item.datain[5:1]};
  				    else // shift
  				       if (item.direction) // left
  				          data_out_ref = {item.datain[4:0], item.serial_in};
  				       else
  				          data_out_ref = {item.serial_in, item.datain[5:1]};
  				 end
		endtask  

	endclass


endpackage : shift_reg_scoreboard_pkg
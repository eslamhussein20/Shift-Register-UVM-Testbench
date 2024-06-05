package shift_reg_sequencer_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import shift_reg_seq_item_pkg::* ;

	class shift_reg_sequencer extends uvm_sequencer #(shift_reg_seq_item);
		`uvm_component_utils(shift_reg_sequencer)
		shift_reg_seq_item seq_item ;

		function new (string name = "shift_reg_sequencer",uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase (uvm_phase phase);
			super.build_phase(phase);
		endfunction

	endclass


endpackage : shift_reg_sequencer_pkg
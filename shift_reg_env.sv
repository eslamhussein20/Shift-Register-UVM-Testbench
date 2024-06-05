package shift_reg_env_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import shift_reg_seq_item_pkg::* ;
	import shift_reg_config_pkg::*;
	import shift_reg_agent_pkg::*;
	import shift_reg_scoreboard_pkg::*;

	class shift_reg_env extends uvm_env ;
		`uvm_component_utils(shift_reg_env)

		shift_reg_agent agt ;
		shift_reg_scoreboard sb ;

		function new (string name = "shift_reg_env",uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase (uvm_phase phase);
			super.build_phase(phase);
			agt = shift_reg_agent::type_id::create("agt",this);
			sb = shift_reg_scoreboard::type_id::create("sb",this);
		endfunction

		function void connect_phase (uvm_phase phase);
			super.connect_phase(phase);
			agt.agt_ap.connect(sb.sb_export);
		endfunction

		task run_phase (uvm_phase phase);
			super.run_phase(phase);
		endtask : run_phase

	endclass


endpackage : shift_reg_env_pkg
package shift_reg_test_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import shift_reg_seq_item_pkg::* ;
	import shift_reg_config_pkg::*;
	import shift_reg_sequnce_pkg::*;
	import shift_reg_env_pkg::*;

	class shift_reg_test extends uvm_test ;
		`uvm_component_utils(shift_reg_test)

		shift_reg_config shift_reg_config_obj ;
		reset_sequence rst_seq ;
		main_sequence main_seq ;
		shift_reg_env env ;

		function new (string name = "shift_reg_test",uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase (uvm_phase phase);
			super.build_phase(phase);
			env = shift_reg_env::type_id::create("env",this);
			rst_seq = reset_sequence::type_id::create("rst_seq",this);
			main_seq = main_sequence::type_id::create("main_seq",this);
			shift_reg_config_obj = shift_reg_config::type_id::create("shift_reg_config_obj");
			if (!uvm_config_db#(virtual shift_reg_if)::get(this, "", "V_IF",shift_reg_config_obj.shift_reg_vif))
					`uvm_info("UVM_TEST_Build_Phase","Unable to get shift_reg_if from uvm_config_db",UVM_LOW);
			uvm_config_db#(shift_reg_config)::set(this, "*", "CFG",shift_reg_config_obj);
		endfunction

		task run_phase (uvm_phase phase);
			super.run_phase(phase);
			phase.raise_objection(this);
			`uvm_info("UVM_TEST_Run_Phase","Rest is Asserted",UVM_LOW);
			rst_seq.start(env.agt.sqr);
			`uvm_info("UVM_TEST_Run_Phase","Rest is De-asserted",UVM_LOW);
			`uvm_info("UVM_TEST_Run_Phase","Stimulus Generation is Started",UVM_LOW);
			main_seq.start(env.agt.sqr);
			`uvm_info("UVM_TEST_Run_Phase","Stimulus Generation is Ended",UVM_LOW);
			phase.drop_objection(this);
		endtask : run_phase

	endclass


endpackage : shift_reg_test_pkg
package shift_reg_agent_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import shift_reg_seq_item_pkg::* ;
	import shift_reg_config_pkg::*;
	import shift_reg_driver_pkg::*;
	import shift_reg_monitor_pkg::*;
	import shift_reg_sequencer_pkg::*;

	class shift_reg_agent extends uvm_agent ;
		`uvm_component_utils(shift_reg_agent)
		uvm_analysis_port #(shift_reg_seq_item) agt_ap;
		shift_reg_driver driver ;
		shift_reg_monitor monitor ;
		shift_reg_sequencer sqr ;
		shift_reg_config shift_reg_config_obj ;

		function new (string name = "shift_reg_agent",uvm_component parent = null);
			super.new(name,parent);
		endfunction

		function void build_phase (uvm_phase phase);
			super.build_phase(phase);
			shift_reg_config_obj = shift_reg_config::type_id::create("shift_reg_config_obj");
			driver = shift_reg_driver::type_id::create("driver",this);
			monitor = shift_reg_monitor::type_id::create("monitor",this);
			sqr = shift_reg_sequencer::type_id::create("sqr",this);
			agt_ap = new("agt_ap",this);
			if(!uvm_config_db#(shift_reg_config)::get(this, "", "CFG", shift_reg_config_obj))
				`uvm_info("UVM_MONITOR_Build_Phase","Unable to get shift_reg_config_obj from uvm_config_db",UVM_LOW);
		endfunction

		function void connect_phase (uvm_phase phase);
			super.connect_phase(phase);
			monitor.shift_reg_vif = shift_reg_config_obj.shift_reg_vif;
			driver.shift_reg_vif = shift_reg_config_obj.shift_reg_vif;
			driver.seq_item_port.connect(sqr.seq_item_export);
			monitor.mon_ap.connect(agt_ap);
		endfunction

		task run_phase (uvm_phase phase);
			super.run_phase(phase);
		endtask : run_phase

	endclass


endpackage 
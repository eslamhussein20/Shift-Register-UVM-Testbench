package shift_reg_sequnce_pkg ;

	import uvm_pkg ::* ;
	`include "uvm_macros.svh"
	import shift_reg_seq_item_pkg::* ;

	class reset_sequence extends uvm_sequence #(shift_reg_seq_item);
		`uvm_object_utils(reset_sequence)
		shift_reg_seq_item seq_item ;

		function new (string name = "reset_sequence");
			super.new(name);
		endfunction

		task body();
			seq_item = shift_reg_seq_item::type_id::create("seq_item");
			start_item (seq_item);
			seq_item.reset = 1'b1 ; 
			seq_item.serial_in = 1'b0 ; 
			seq_item.direction = 1'b0 ; 
			seq_item.mode = 1'b0 ; 
			seq_item.datain = 6'b000000 ; 
			finish_item (seq_item);
		endtask 
	endclass

	class main_sequence extends uvm_sequence #(shift_reg_seq_item);
		`uvm_object_utils(main_sequence)
		shift_reg_seq_item seq_item ;

		function new (string name = "main_sequence");
			super.new(name);
		endfunction

		task body();
			seq_item = shift_reg_seq_item::type_id::create("seq_item");
			repeat(10)
				begin
					start_item (seq_item);
					assert(seq_item.randomize()) ; 
					seq_item.reset = 0 ;
					finish_item (seq_item);
				end
		endtask 
	endclass

endpackage
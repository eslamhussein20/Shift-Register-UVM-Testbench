module shift_reg_top ();
`include "uvm_macros.svh"
import uvm_pkg::* ;
import shift_reg_test_pkg::* ;

bit clk ;

initial 
	begin
		clk = 0;
		forever
			begin
				#5
				clk = ~clk;
			end
	end
shift_reg_if s_if (clk);

shift_reg DUT (clk, s_if.reset, s_if.serial_in, s_if.direction, s_if.mode, s_if.datain, s_if.dataout);


initial
	begin
		uvm_config_db#(virtual shift_reg_if )::set(null, "*", "V_IF", s_if);
		run_test ("shift_reg_test");
	end


endmodule : shift_reg_top
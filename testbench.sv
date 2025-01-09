// Code your testbench here
// or browse Examples

//-------------------------------------------
// Top level Test module
//  Includes all env component and sequences files 
//    (you could ideally create an env package and import that as well instead of including)
//-------------------------------------------


 import uvm_pkg::*;
`include "uvm_macros.svh"
`include "apb_if.sv"
`include "apb_pkg.sv"
import apb_pkg::*;

//--------------------------------------------------------
//Top level module that instantiates  just a physical apb interface
//No real DUT or APB slave as of now
//--------------------------------------------------------
module test;

	logic pclk;

	//Instantiate a physical interface for APB interface
	apb_if  apb_if(.pclk(pclk));

	cmsdk_apb_timer dut(.PCLK(apb_if.pclk),
						.PCLKG(apb_if.pclkg),
						.PRESETn(apb_if.presetn),
						.PSEL(apb_if.psel),
						.PADDR(apb_if.paddr),
						.PENABLE(apb_if.penable),
						.PWRITE(apb_if.pwrite),
						.PWDATA(apb_if.pwdata),
						.ECOREVNUM(apb_if.ecorevnum),
						.PRDATA(apb_if.prdata),
						.PREADY(apb_if.pready),
						.PSLVERR(apb_if.pslverr),
						.EXTIN(apb_if.extin),
						.TIMERINT(apb_if.timerint)
						);

	// cmsdk_apb_timer dut(pclk,
	// 					pclk,
	// 					apb_if.presetn,
	// 					apb_if.psel,
	// 					apb_if.paddr[11:2],
	// 					apb_if.penable,
	// 					apb_if.pwrite,
	// 					apb_if.pwdata,
	// 					4'h0,
	// 					apb_if.prdata,
	// 					pready,
	// 					pslverr,
	// 					apb_if.extin,
	// 					apb_if.timerint);

	initial begin
		pclk=0;
	end

	//Generate a clock
	always begin
		#10 pclk = ~pclk;
	end

	initial
		begin
		apb_if.presetn=0;
			@ (posedge pclk)
			apb_if.presetn=1;
		end

	initial begin
		//Pass this physical interface to test top (which will further pass it down to env->agent->drv/sqr/mon
		uvm_config_db#(virtual apb_if)::set( null, "uvm_test_top", "vif", apb_if);
		//Call the test - but passing run_test argument as test class name
		//Another option is to not pass any test argument and use +UVM_TEST on command line to sepecify which test to run
		run_test("apb_base_test");
		//run_test("apb_reg_rst_test");
	end
	
	initial
		begin
		$dumpfile("APB_Timer.vcd");
		$dumpvars();
		end
	
endmodule


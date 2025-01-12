 import uvm_pkg::*;
`include "uvm_macros.svh"
`include "apb_if.sv"
`include "apb_pkg.sv"
import apb_pkg::*;

module test;

	logic pclk;

	//Instantiate a physical interface for APB interface
	apb_if  apb_if(.pclk(pclk));

	cool_apb_device dut(.PCLK(apb_if.pclk),
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
		uvm_config_db#(virtual apb_if)::set( null, "uvm_test_top", "vif", apb_if);
		run_test("apb_base_test");
	end
	
	initial
		begin
		$dumpfile("APB_cool_dev.vcd");
		$dumpvars();
		end
	
endmodule


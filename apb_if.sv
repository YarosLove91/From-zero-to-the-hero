interface apb_if(input bit pclk);
	logic [31:0] paddr;
	logic        psel;
	logic        penable;
	logic        pwrite;
	logic [31:0] prdata;
	logic [31:0] pwdata;
	logic [31:0] ecorevnum;
	logic extin;
	logic timerint;
	logic pclkg;
	logic presetn;
	logic pslverr;
	logic pready;
	


   //Master Clocking block - used for Drivers
	clocking master_cb @(posedge pclk);
		output paddr, 
			   psel, 
			   penable, 
			   pwrite, 
			   pwdata;
		input  prdata;
	endclocking: master_cb

	//Monitor Clocking block - For sampling by monitor components
	clocking monitor_cb @(posedge pclk);
		input paddr, 
			  psel, 
			  penable, 
			  pwrite, 
			  prdata, 
			  pwdata;
	endclocking: monitor_cb

	modport master(clocking master_cb);
	modport passive(clocking monitor_cb);

endinterface: apb_if

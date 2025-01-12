module cool_apb_device (
	input  wire        PCLK,    // PCLK for timer operation
	input  wire        PCLKG,   // Gated clock
	input  wire        PRESETn, // Reset

	input  wire        PSEL,    // Device select
	input  wire [11:2] PADDR,   // Address
	input  wire        PENABLE, // Transfer control
	input  wire        PWRITE,  // Write control
	input  wire [31:0] PWDATA,  // Write data

	output wire [31:0] PRDATA,  // Read data
	output wire        PREADY,  // Device ready
	output wire        PSLVERR, // Device error response

	input  wire        EXTIN,   // External input

	output wire        TIMERINT
	); // Timer interrupt output


endmodule

//------------------------------------
// Basic APB  Read/Write Transaction class definition this will be used by Sequences, Drivers and Monitors
//------------------------------------

// Transaction class
//apb_rw sequence item derived from base uvm_sequence_item
class apb_rw extends uvm_sequence_item;
	
	//typedef for READ/Write transaction type
	typedef enum {READ, WRITE} kind_e;
	rand bit   [31:0] addr;      //Address
	rand logic [31:0] data;     //Data - For write or read response
	rand kind_e  apb_cmd;       //command type

		//Register with factory for dynamic creation
	`uvm_object_utils(apb_rw)
	
	
	function new (string name = "apb_rw");
		super.new(name);
	endfunction
	
	constraint addr_write { 
		if(apb_cmd == WRITE) {
					addr[11:0] inside { 12'h000,12'h004,
										12'h008,12'h00C};
		}
		else{
			addr[11:0] inside { 12'h000, 12'h004,
								12'h008, 12'h00C,
								12'hFD0, 12'hFD4,
								12'hFD8, 12'hFDC,
								12'hFE0, 12'hFE4,
								12'hFE8, 12'hFEC,
								12'hFF0, 12'hFF4,
								12'hFF8, 12'hFFC
								};}
						}
	
	constraint addr_31_12 {addr[31:12] == 20'h00000;}
								
	//constraint write_addr{soft addr[11:0] inside{12'h000,12'h004,12'h008,12'h00C};}

	function string convert2string();
		return $psprintf("kind=%0s::addr=%0h::data=%0h ",apb_cmd.name(),addr,data);
	endfunction

endclass: apb_rw


	//---------------------------------------------
	// APB master driver Class  
	//---------------------------------------------
	class apb_master_drv extends uvm_driver#(apb_rw);
	
	`uvm_component_utils(apb_master_drv)
	
	virtual apb_if vif;
		apb_rw tr;
	//enable bit for EXTIN
	bit extin_en=1'b0;

	function new(string name,uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//Build Phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=apb_rw::type_id::create("tr");
			if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif)) begin
			// ...
			end
	endfunction

	//Run Phase
	//Based on if it is Read/Write - drive on APB interface the corresponding pins
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		master_cb.psel    <= 1'b0;
		master_cb.penable <= 1'b0;
		
		// fork
		// begin
		// 	if(extin_en==0)
		// 	begin
		// 		@(posedge extin)
		// 		extin_en=1'b1;
		// 	end
		// end
		
		forever begin
		@ (this.vif.master_cb);
		seq_item_port.get_next_item(tr);
		@ (this.vif.master_cb);
		uvm_report_info("APB_DRIVER ", $psprintf("Got Transaction %s",tr.convert2string()));

		//Decode the APB Command and call either the read/write function
		case (tr.apb_cmd)
			apb_rw::READ:  drive_read(tr.addr, tr.data);  
			apb_rw::WRITE: drive_write(tr.addr, tr.data);
		endcase
		//Handshake DONE back to sequencer
		seq_item_port.item_done();
		end
		join
	endtask: run_phase

	virtual protected task drive_read(input  bit   [31:0] addr,
										output logic [31:0] data);
		// master_cb.paddr   <= addr;
		// master_cb.pwrite  <= 1'b0;
		// master_cb.psel    <= 1'b1;
		// master_cb.penable <= 1'b1;
		// Считать данные
		// master_cb.psel    <= 1'b0;
		// master_cb.penable <= 1'b0;
	endtask: drive_read

	virtual protected task drive_write(input bit [31:0] addr,
									input bit [31:0] data);
		bit [31:0] temp_data; 
		// master_cb.paddr   <= addr;
		// master_cb.pwdata  <= data;
		// master_cb.pwrite  <= 1'b1;
		// master_cb.psel    <= 1'b1;
		// master_cb.penable <= 1'b1;
		// master_cb.psel    <= 1'b0;
		// master_cb.penable <= 1'b0;
	endtask: drive_write

	endclass: apb_master_drv



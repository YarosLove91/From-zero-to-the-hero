//-----------------------------------------
// APB Monitor class  
//-----------------------------------------
class apb_monitor extends uvm_monitor;

	`uvm_component_utils(apb_monitor)
		virtual apb_if vif;
		apb_rw tr;
	
	//
	uvm_analysis_port#(apb_rw) ap;

	function new(string name, uvm_component parent = null);
		super.new(name, parent);
		ap = new("ap", this);
	endfunction: new

	//Build Phase - 
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=apb_rw::type_id::create("tr");
		if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif",vif)) begin
			// ...
		end
	endfunction

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
		do begin
			@ (this.vif.monitor_cb);
			end
			while (this.vif.monitor_cb.psel !== 1'b1 ||
					this.vif.monitor_cb.penable !== 1'b0);
			
			// based on values seen on interface pwrite 
			tr.apb_cmd = (this.vif.monitor_cb.pwrite) ? apb_rw::WRITE : apb_rw::READ;
			tr.addr = this.vif.monitor_cb.paddr;

			@ (this.vif.monitor_cb);
			if (this.vif.monitor_cb.penable !== 1'b1) begin
				// ...
			end
			tr.data = (tr.apb_cmd == apb_rw::READ) ? this.vif.monitor_cb.prdata : '0;
			tr.data = (tr.apb_cmd == apb_rw::WRITE) ? this.vif.monitor_cb.pwdata : '0;
			uvm_report_info("APB_MONITOR", $psprintf("Got Transaction %s",tr.convert2string()));
			//Write to analysis port
			ap.write(tr);
		end
	endtask: run_phase

endclass: apb_monitor


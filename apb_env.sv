//----------------------------------------------
// APB Env class
//----------------------------------------------
class apb_env  extends uvm_env;

	`uvm_component_utils(apb_env)

	apb_agent  agt;
	//apb_scoreboard scob;

	//virtual interface for APB interface
	virtual apb_if  vif;

	function new(string name, uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		agt = apb_agent::type_id::create("agt", this);
		//scob = apb_scoreboard::type_id::create("scob", this);
		if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif)) begin
			`uvm_fatal("APB/AGT/NOVIF", "No virtual interface specified for this env instance")
		end
		uvm_config_db#(virtual apb_if)::set( this, "agt", "vif", vif);
	endfunction: build_phase

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		//Analysis port connection
		//agt.mon.ap.connect(scob.ap_imp);
	endfunction
endclass : apb_env  


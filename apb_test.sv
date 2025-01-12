class apb_base_test extends uvm_test;

  //Register with factory
	`uvm_component_utils(apb_base_test)
	
	apb_env  env;
	apb_base_seq apb_seq;
	virtual apb_if vif;
	
	function new(string name = "apb_base_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	//Build phase   
	
	function void build_phase(uvm_phase phase);
		env = apb_env::type_id::create("env", this);
		apb_seq = apb_base_seq::type_id::create("apb_seq");
		if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif)) begin
			// ...
		end 
		uvm_config_db#(virtual apb_if)::set( this, );
	endfunction

	//Run phase 
	task run_phase( uvm_phase phase );
		phase.raise_objection( this, "Starting apb_base_seqin main phase" );
		$display("%t Starting sequence apb_seq run_phase",$time);
		apb_seq.start(env.agt.sqr);
		#100ns;
		phase.drop_objection( this , "Finished apb_seq in main phase" );
	endtask: run_phase
	
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		// ...
	endfunction 
endclass

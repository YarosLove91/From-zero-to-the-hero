//---------------------
// APB Scoreboard class
// --------------------
//
class apb_scoreboard extends uvm_scoreboard;
//registration to the factory
`uvm_component_utils(apb_scoreboard)

	//Components
	apb_base_seq seq;
	//reg_rst_seq reg_rst_seq_h;
	apb_rw tr;

	//Analysis imp port
	uvm_analysis_imp#(apb_rw, apb_scoreboard)ap_imp;

	function new(string name="APB_SCOB", uvm_component parent=null);
		super.new(name,parent);
		ap_imp=new("ap_imp",this);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=apb_rw::type_id::create("tr",this);
		seq=apb_base_seq::type_id::create("seq",this);
	endfunction

	virtual function void write(apb_rw tr);
		///...
	endfunction

	virtual task run_phase(uvm_phase phase);
endtask

endclass:apb_scoreboard


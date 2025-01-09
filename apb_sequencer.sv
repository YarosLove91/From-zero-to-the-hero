//---------------------------------------------
// APB Sequencer Class  
//  Derive form uvm_sequencer and parameterize to apb_rw sequence item
//---------------------------------------------
class apb_sequencer extends uvm_sequencer #(apb_rw);

	`uvm_component_utils(apb_sequencer)

	function new(input string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

endclass : apb_sequencer



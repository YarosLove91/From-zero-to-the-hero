//------------------------
//APB REG RESET sequence derived from apb_base_sequence and parameterized with sequence item of type apb_rw
//------------------------

//typedef apb_base_seq;
//class reg_rst_seq extends apb_base_seq#(apb_rw);
class reg_rst_seq extends uvm_sequence#(apb_rw);

	`uvm_object_utils(reg_rst_seq)
	//apb_base_seq apb_base_seq_h;
	apb_rw rw_trans;
	int reg_array[16]='{
		// ...
	}; 
	
	function new(string name ="REG_RST_SEQ");
		super.new(name);
	endfunction


	//Main Body method that gets executed once sequence is started
	task body();
		//SEQ for the REG RESET
		//apb_rw rw_trans;
		rw_trans = apb_rw::type_id::create( .name("rw_trans"),
											.contxt(get_full_name()));
		foreach (this.reg_array[i])begin
			start_item(rw_trans);
			assert (rw_trans.randomize()with{rw_trans.addr == reg_array[i];rw_trans.apb_cmd==apb_rw::READ;});
			//rw_trans.print();
			finish_item(rw_trans);
		end
	endtask

endclass



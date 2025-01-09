//A few flavours of apb sequences

//------------------------
//Base APB sequence derived from uvm_sequence and parameterized with sequence item of type apb_rw
//------------------------
class apb_base_seq extends uvm_sequence#(apb_rw);

	`uvm_object_utils(apb_base_seq)
		apb_rw rw_trans;

	function new(string name ="");
		super.new(name);
	endfunction


	//Main Body method that gets executed once sequence is started
	task body();
		rw_trans = apb_rw::type_id::create(.name("rw_trans"),.contxt(get_full_name()));
		//Create 1 random APB read/write transaction and send to driver
		repeat(40) begin
		start_item(rw_trans);
		assert (rw_trans.randomize() with { rw_trans.data[31:16]==16'h0000;
											rw_trans.data[3:0] inside {4'b1001, 4'b1101};
										  }
				);
		//rw_trans.print();
		finish_item(rw_trans);
		end
	endtask
	
endclass


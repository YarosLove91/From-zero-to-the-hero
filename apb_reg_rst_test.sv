//--------------------------------------------------------
//Reg Reset Test class that instantiates env, and starts stimulus
//--------------------------------------------------------

//typedef apb_base_test;
//class apb_reg_rst_test extends apb_base_test;
class apb_reg_rst_test extends uvm_test;

    //Register with factory
    `uvm_component_utils(apb_reg_rst_test)

    //apb_base_test apb_base_test_h;
    apb_env  env;
    reg_rst_seq reg_rst_seq_h;
    virtual apb_if vif;

    function new(string name = "apb_reg_rst_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    //Build phase   

    function void build_phase(uvm_phase phase);
        env = apb_env::type_id::create("env", this);
        reg_rst_seq_h = reg_rst_seq::type_id::create("reg_rst_seq_h");
        if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("APB/DRV/NOVIF", "No virtual interface specified for this test instance")
        end 
        uvm_config_db#(virtual apb_if)::set( this, "env", "vif", vif);
    endfunction

    //Run phase 
    task run_phase( uvm_phase phase );
        phase.raise_objection( this, "Starting reg_rst_seq in main phase" );
        $display("%t Starting sequence reg_rst_seq run_phase",$time);
        reg_rst_seq_h.start(env.agt.sqr);
        #100ns;
        phase.drop_objection( this , "Finished reg_rst_seq in main phase" );
    endtask: run_phase

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        print();// topology
    endfunction 
endclass


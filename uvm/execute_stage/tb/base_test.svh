//------------------------------------------------------------------------------
// Class base_test
// 
// Base class for all UVM test derived from uvm_test
// 
// This class contains the basic structure of UVM test class and provides some
// basic sequence and environment to make it easier for users to create
// test cases.
// 
// This class includes:
//  - base_test: Base class for all UVM test derived from uvm_test
//  - base_test::build_phase: Function to build the class within UVM build phase
//  - base_test::run_phase: Start UVM test in running phase
// 
// This class is a part of the test library.
// 
//------------------------------------------------------------------------------
class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    // Testbench top configuration object with all setup for the TB
    top_config  m_top_config;
    // Testbench environment
    tb_env  m_tb_env;
    // Number of loop with generate data_serial_data transaction
    int unsigned no_of_data_loop = 40;

    //------------------------------------------------------------------------------
// FUNCTION: new
    // Creates and constructs the sequence.
    //------------------------------------------------------------------------------
    function new (string name = "test",uvm_component parent = null);
        super.new(name,parent);
        // Get TB TOP configuration from UVM DB
        if ((uvm_config_db #(top_config)::get(null, "tb_top", "top_config", m_top_config))==0) begin
            `uvm_fatal(get_name(),"Cannot find <top_config> TB configuration!")
        end
    endfunction : new

    //------------------------------------------------------------------------------
    // FUNCTION: build_phase
    // Function to build the class within UVM build phase.
    //------------------------------------------------------------------------------
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Create TB verification environment
        m_tb_env = tb_env::type_id::create("m_tb_env",this);
    endfunction : build_phase

    //------------------------------------------------------------------------------
    // FUNCTION: run_phase
    // Start UVM test in running phase.
    //------------------------------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        pc_seq pc;
        control_in_seq control_in;
        data1_seq data1;
        data2_seq data2;
        immediate_data_seq immediate_data;
        rd_in_seq rd_in;
        rs1_seq rs1;
        rs2_seq rs2;
        ex_mem_rd_seq ex_mem_rd;
        mem_wb_rd_seq mem_wb_rd;
        ex_mem_RegWrite_seq ex_mem_RegWrite;
        mem_wb_RegWrite_seq mem_wb_RegWrite;
        forward_ex_mem_seq forward_ex_mem;  
        forward_mem_wb_seq forward_mem_wb;

        super.run_phase(phase);
        `uvm_info(get_name(),$sformatf("UVM TB Starts UVM test; '%s'",get_name()),UVM_NONE)
        // Raise objection if no UVM test is running
        phase.raise_objection(this);
        
        // Fork two processes that running in parallel
        fork
            // Randomize reset the DUT no_of_data_loop times
            begin
                repeat (no_of_data_loop) begin
                    pc = pc_seq::type_id::create("pc");
                    if(!(pc.randomize())) `uvm_fatal(get_name(), "Failed to randomize pc")
                    pc.start(m_tb_env.m_pc_agent.m_sequencer);

                    control_in = control_in_seq::type_id::create("control_in");
                    if(!(control_in.randomize())) `uvm_fatal(get_name(), "Failed to randomize control_in")
                    control_in.start(m_tb_env.m_control_in_agent.m_sequencer);

                    data1 = data1_seq::type_id::create("data1");
                    if(!(data1.randomize())) `uvm_fatal(get_name(), "Failed to randomize data1")
                    data1.start(m_tb_env.m_data1_agent.m_sequencer);

                    data2 = data2_seq::type_id::create("data2");
                    if(!(data2.randomize())) `uvm_fatal(get_name(), "Failed to randomize data2")
                    data2.start(m_tb_env.m_data2_agent.m_sequencer);

                    immediate_data = immediate_data_seq::type_id::create("immediate_data");
                    if(!(immediate_data.randomize())) `uvm_fatal(get_name(), "Failed to randomize immediate_data")
                    immediate_data.start(m_tb_env.m_immediate_data_agent.m_sequencer);

                    rd_in = rd_in_seq::type_id::create("rd_in");
                    if(!(rd_in.randomize())) `uvm_fatal(get_name(), "Failed to randomize rd_in")
                    rd_in.start(m_tb_env.m_rd_in_agent.m_sequencer);

                    rs1 = rs1_seq::type_id::create("rs1");
                    if(!(rs1.randomize())) `uvm_fatal(get_name(), "Failed to randomize rs1")
                    rs1.start(m_tb_env.m_rs1_agent.m_sequencer);

                    rs2 = rs2_seq::type_id::create("rs2");
                    if(!(rs2.randomize())) `uvm_fatal(get_name(), "Failed to randomize rs2")
                    rs2.start(m_tb_env.m_rs2_agent.m_sequencer);

                    ex_mem_rd = ex_mem_rd_seq::type_id::create("ex_mem_rd");
                    if(!(ex_mem_rd.randomize())) `uvm_fatal(get_name(), "Failed to randomize ex_mem_rd")
                    ex_mem_rd.start(m_tb_env.m_ex_mem_rd_agent.m_sequencer);

                    mem_wb_rd = mem_wb_rd_seq::type_id::create("mem_wb_rd");
                    if(!(mem_wb_rd.randomize())) `uvm_fatal(get_name(), "Failed to randomize mem_wb_rd")
                    mem_wb_rd.start(m_tb_env.m_mem_wb_rd_agent.m_sequencer);

                    ex_mem_RegWrite = ex_mem_RegWrite_seq::type_id::create("ex_mem_RegWrite");
                    if(!(ex_mem_RegWrite.randomize())) `uvm_fatal(get_name(), "Failed to randomize ex_mem_RegWrite")
                    ex_mem_RegWrite.start(m_tb_env.m_ex_mem_RegWrite_agent.m_sequencer);

                    mem_wb_RegWrite = mem_wb_RegWrite_seq::type_id::create("mem_wb_RegWrite");
                    if(!(mem_wb_RegWrite.randomize())) `uvm_fatal(get_name(), "Failed to randomize mem_wb_RegWrite")
                    mem_wb_RegWrite.start(m_tb_env.m_mem_wb_RegWrite_agent.m_sequencer);

                    forward_ex_mem = forward_ex_mem_seq::type_id::create("forward_ex_mem");
                    if(!(forward_ex_mem.randomize())) `uvm_fatal(get_name(), "Failed to randomize forward_ex_mem")
                    forward_ex_mem.start(m_tb_env.m_forward_ex_mem_agent.m_sequencer);

                    forward_mem_wb = forward_mem_wb_seq::type_id::create("forward_mem_wb");
                    if(!(forward_mem_wb.randomize())) `uvm_fatal(get_name(), "Failed to randomize forward_mem_wb")
                    forward_mem_wb.start(m_tb_env.m_forward_mem_wb_agent.m_sequencer);
                end
            end        
        join
        #100ns;
        // Drop objection if no UVM test is running
        phase.drop_objection(this);
    endtask : run_phase

endclass : base_test

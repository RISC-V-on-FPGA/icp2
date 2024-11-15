//------------------------------------------------------------------------------
// tb_env class
//
// This class represents the environment of the TB (Test Bench) which is
// composed by the different agents and the scoreboard
// The environment is initialized by getting the TB configuration from the UVM
// database and then creating all the components
//
// The environment connects the monitor analysis ports of the agents to the
// scoreboard
//
//------------------------------------------------------------------------------
class tb_env extends uvm_env;
    `uvm_component_utils(tb_env)

    // TB configuration object with all setup for the TB environment
    top_config   m_top_config;
    // scoreboard scoreboard.
    scoreboard   m_scoreboard;

    // All the agents
    alu_data_agent m_alu_data;
    clock_agent  m_clock_agent;
    control_in_agent m_control_in_agent;
    control_out_agent m_control_out_agent;
    data1_agent m_data1_agent;
    data2_agent m_data2_agent;
    ex_mem_rd_agent  m_ex_mem_rd_agent;
    ex_mem_RegWrite_agent m_ex_mem_RegWrite_agent;
    forward_ex_mem_agent m_forward_ex_mem_agent;
    forward_mem_wb_agent m_forward_mem_wb_agent;
    immediate_data_agent m_immediate_data_agent;
    mem_wb_rd_agent m_mem_wb_rd_agent;
    mem_wb_RegWrite_agent m_mem_wb_RegWrite_agent;
    memory_data_agent m_memory_data_agent;
    pc_out_agent m_pc_out_agent;
    pc_agent m_pc_agent;
    rd_in_agent m_rd_in_agent;
    rd_out_agent m_rd_out_agent;
    rs1_agent m_rs1_agent;
    rs2_agent m_rs2_agent;
    ZeroFlag_agent m_ZeroFlag_agent;


    //------------------------------------------------------------------------------
    // Creates and initializes an instance of this class using the normal
    // constructor arguments for uvm_component.
    //------------------------------------------------------------------------------
    function new (string name = "tb_env" , uvm_component parent = null);
        super.new(name,parent);
        // Get TOP TB configuration from UVM DB
        if ((uvm_config_db #(top_config)::get(null, "tb_top", "top_config", m_top_config))==0) begin
            `uvm_fatal(get_name(),"Cannot find <top_config> TB configuration!")
        end
    endfunction : new

    //------------------------------------------------------------------------------
    // Build all the components in the TB environment
    //------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Build all TB VC's

        uvm_config_db #(alu_data_config)::set(this,"m_alu_data_agent*","config", m_top_config.m_alu_data_config);
        m_alu_data_agent = alu_data_agent::type_id::create("m_alu_data_agent",this);

        uvm_config_db #(clock_config)::set(this,"m_clock_agent*","config", m_top_config.m_clock_config);
        m_clock_agent = clock_agent::type_id::create("m_clock_agent",this);

        uvm_config_db #(control_in_config)::set(this,"m_control_in_agent*","config", m_top_config.m_control_in_config);
        m_control_in_agent = control_in_agent::type_id::create("m_control_in_agent",this);

        uvm_config_db #(control_out_config)::set(this,"m_control_out_agent*","config", m_top_config.m_control_out_config);
        m_control_out_agent = control_out_agent::type_id::create("m_control_out_agent",this);

        uvm_config_db #(data1_config)::set(this,"m_data1_agent*","config", m_top_config.m_data1_config);
        m_data1_agent = data1_agent::type_id::create("m_data1_agent",this);

        uvm_config_db #(data2_config)::set(this,"m_data2_agent*","config", m_top_config.m_data2_config);
        m_data2_agent = data2_agent::type_id::create("m_data2_agent",this);

        uvm_config_db #(ex_mem_rd_config)::set(this,"m_ex_mem_rd_agent*","config", m_top_config.m_ex_mem_rd_config);
        m_ex_mem_rd_agent = ex_mem_rd_agent::type_id::create("m_ex_mem_rd_agent",this);

        uvm_config_db #(ex_mem_RegWrite_config)::set(this,"m_ex_mem_RegWrite_agent*","config", m_top_config.m_ex_mem_RegWrite_config);
        m_ex_mem_RegWrite_agent = ex_mem_RegWrite_agent::type_id::create("m_ex_mem_RegWrite_agent",this);

        uvm_config_db #(forward_ex_mem_config)::set(this,"m_forward_ex_mem_agent*","config", m_top_config.m_forward_ex_mem_config);
        m_forward_ex_mem_agent = forward_ex_mem_agent::type_id::create("m_forward_ex_mem_agent",this);

        uvm_config_db #(forward_mem_wb_config)::set(this,"m_forward_mem_wb_agent*","config", m_top_config.m_forward_mem_wb_config);
        m_forward_mem_wb_agent = forward_mem_wb_agent::type_id::create("m_forward_mem_wb_agent",this);

        uvm_config_db #(immediate_data_config)::set(this,"m_immediate_data_agent*","config", m_top_config.m_immediate_data_config);
        m_immediate_data_agent = immediate_data_agent::type_id::create("m_immediate_data_agent",this);

        uvm_config_db #(mem_wb_rd_config)::set(this,"m_mem_wb_rd_agent*","config", m_top_config.m_mem_wb_rd_config);
        m_mem_wb_rd_agent = mem_wb_rd_agent::type_id::create("m_mem_wb_rd_agent",this);

        uvm_config_db #(mem_wb_RegWrite_config)::set(this,"m_mem_wb_RegWrite_agent*","config", m_top_config.m_mem_wb_RegWrite_config);
        m_mem_wb_RegWrite_agent = mem_wb_RegWrite_agent::type_id::create("m_mem_wb_RegWrite_agent",this);

        uvm_config_db #(memory_data_config)::set(this,"m_memory_data_agent*","config", m_top_config.m_memory_data_config);
        m_memory_data_agent = memory_data_agent::type_id::create("m_memory_data_agent",this);

        uvm_config_db #(pc_out_config)::set(this,"m_pc_out_agent*","config", m_top_config.m_pc_out_config);
        m_pc_out_agent = pc_out_agent::type_id::create("m_pc_out_agent",this);

        uvm_config_db #(pc_config)::set(this,"m_pc_agent*","config", m_top_config.m_pc_config);
        m_pc_agent = pc_agent::type_id::create("m_pc_agent",this);

        uvm_config_db #(rd_in_config)::set(this,"m_rd_in_agent*","config", m_top_config.m_rd_in_config);
        m_rd_in_agent = rd_in_agent::type_id::create("m_rd_in_agent",this);

        uvm_config_db #(rd_out_config)::set(this,"m_rd_out_agent*","config", m_top_config.m_rd_out_config);
        m_rd_out_agent = rd_out_agent::type_id::create("m_rd_out_agent",this);

        uvm_config_db #(rs1_config)::set(this,"m_rs1_agent*","config", m_top_config.m_rs1_config);
        m_rs1_agent = rs1_agent::type_id::create("m_rs1_agent",this);

        uvm_config_db #(rs2_config)::set(this,"m_rs2_agent*","config", m_top_config.m_rs2_config);
        m_rs2_agent = rs2_agent::type_id::create("m_rs2_agent",this);

        uvm_config_db #(ZeroFlag_config)::set(this,"m_ZeroFlag_agent*","config", m_top_config.m_ZeroFlag_config);
        m_ZeroFlag_agent = ZeroFlag_agent::type_id::create("m_ZeroFlag_agent",this);

        // Build scoreboard components
        m_scoreboard = scoreboard::type_id::create("m_scoreboard",this);
    endfunction : build_phase

    //------------------------------------------------------------------------------
    // This function is used to connection the uVC monitor analysis ports to the scoreboard
    //------------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // Making all connection all analysis ports to scoreboard
        m_reset_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_reset_ap);
        m_serial_data_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_serial_data_ap);
        m_parallel_data_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_parallel_data_ap);
    endfunction : connect_phase

endclass : tb_env

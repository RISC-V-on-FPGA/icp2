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

    // Adresses
    address_agent     m_rd_in_agent;
    address_agent     m_rd_out_agent;
    address_agent     m_rs1_agent;
    address_agent     m_rs2_agent;
    address_agent     m_ex_mem_rd_agent;
    address_agent     m_mem_wb_rd_agent;
    // clocks
    clock_agent      m_clock_agent;
    // controls
    control_agent    m_control_in_agent;
    control_agent    m_control_out_agent;
    // datas
    data_agent       m_data1_agent;
    data_agent       m_data2_agent;
    data_agent       m_alu_data_agent;
    data_agent       m_memory_data_agent;
    data_agent       m_forward_ex_mem_agent;
    data_agent       m_forward_mem_wb_agent;
    data_agent       m_immediate_data_agent;
    // pcs
    pc_agent         m_pc_agent;
    pc_agent         m_pc_out_agent;
    // RegWrites
    RegWrite_agent   m_ex_mem_RegWrite_agent;
    RegWrite_agent   m_mem_wb_RegWrite_agent;
    // ZeroFlags
    ZeroFlag_agent   m_ZeroFlag_agent;

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

        // Alu data
        uvm_config_db #(data_config)::set(this,"m_alu_data_agent*","config", m_top_config.m_alu_data_config);
        m_alu_data_agent = data_agent::type_id::create("m_alu_data_agent",this);

        // Clock
        uvm_config_db #(clock_config)::set(this,"m_clock_agent*","config", m_top_config.m_clock_config);
        m_clock_agent = clock_agent::type_id::create("m_clock_agent",this);

        // control_in
        uvm_config_db #(control_config)::set(this,"m_control_in_agent*","config", m_top_config.m_control_in_config);
        m_control_in_agent = control_agent::type_id::create("m_control_in_agent",this);

        // control_out
        uvm_config_db #(control_config)::set(this,"m_control_out_agent*","config", m_top_config.m_control_out_config);
        m_control_out_agent = control_agent::type_id::create("m_control_out_agent",this);

        // data1
        uvm_config_db #(data_config)::set(this,"m_data1_agent*","config", m_top_config.m_data1_config);
        m_data1_agent = data_agent::type_id::create("m_data1_agent",this);

        // data2
        uvm_config_db #(data_config)::set(this,"m_data2_agent*","config", m_top_config.m_data2_config);
        m_data2_agent = data_agent::type_id::create("m_data2_agent",this);

        // ex_mem_rd
        uvm_config_db #(address_config)::set(this,"m_ex_mem_rd_agent*","config", m_top_config.m_ex_mem_rd_config);
        m_ex_mem_rd_agent = address_agent::type_id::create("m_ex_mem_rd_agent",this);

        // ex_mem_RegWrite
        uvm_config_db #(RegWrite_config)::set(this,"m_ex_mem_RegWrite_agent*","config", m_top_config.m_ex_mem_RegWrite_config);
        m_ex_mem_RegWrite_agent = RegWrite_agent::type_id::create("m_ex_mem_RegWrite_agent",this);

        // forward_ex_mem
        uvm_config_db #(data_config)::set(this,"m_forward_ex_mem_agent*","config", m_top_config.m_forward_ex_mem_config);
        m_forward_ex_mem_agent = data_agent::type_id::create("m_forward_ex_mem_agent",this);

        // forward_mem_wb
        uvm_config_db #(data_config)::set(this,"m_forward_mem_wb_agent*","config", m_top_config.m_forward_mem_wb_config);
        m_forward_mem_wb_agent = data_agent::type_id::create("m_forward_mem_wb_agent",this);

        // immediate_data
        uvm_config_db #(data_config)::set(this,"m_immediate_data_agent*","config", m_top_config.m_immediate_data_config);
        m_immediate_data_agent = data_agent::type_id::create("m_immediate_data_agent",this);

        // mem_wb_rd
        uvm_config_db #(address_config)::set(this,"m_mem_wb_rd_agent*","config", m_top_config.m_mem_wb_rd_config);
        m_mem_wb_rd_agent = address_agent::type_id::create("m_mem_wb_rd_agent",this);

        // mem_wb_RegWrite
        uvm_config_db #(RegWrite_config)::set(this,"m_mem_wb_RegWrite_agent*","config", m_top_config.m_mem_wb_RegWrite_config);
        m_mem_wb_RegWrite_agent = RegWrite_agent::type_id::create("m_mem_wb_RegWrite_agent",this);

        // memory_data
        uvm_config_db #(data_config)::set(this,"m_memory_data_agent*","config", m_top_config.m_memory_data_config);
        m_memory_data_agent = data_agent::type_id::create("m_memory_data_agent",this);

        // pc_out
        uvm_config_db #(pc_config)::set(this,"m_pc_out_agent*","config", m_top_config.m_pc_out_config);
        m_pc_out_agent = pc_agent::type_id::create("m_pc_out_agent",this);

        // pc
        uvm_config_db #(pc_config)::set(this,"m_pc_agent*","config", m_top_config.m_pc_config);
        m_pc_agent = pc_agent::type_id::create("m_pc_agent",this);

        // rd_in
        uvm_config_db #(address_config)::set(this,"m_rd_in_agent*","config", m_top_config.m_rd_in_config);
        m_rd_in_agent = address_agent::type_id::create("m_rd_in_agent",this);

        // rd_out
        uvm_config_db #(address_config)::set(this,"m_rd_out_agent*","config", m_top_config.m_rd_out_config);
        m_rd_out_agent = address_agent::type_id::create("m_rd_out_agent",this);

        // rs1
        uvm_config_db #(address_config)::set(this,"m_rs1_agent*","config", m_top_config.m_rs1_config);
        m_rs1_agent = address_agent::type_id::create("m_rs1_agent",this);

        // rs2
        uvm_config_db #(address_config)::set(this,"m_rs2_agent*","config", m_top_config.m_rs2_config);
        m_rs2_agent = address_agent::type_id::create("m_rs2_agent",this);

        // ZeroFlag
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
        m_pc_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_pc_ap);
        m_control_in_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_control_in_ap);
        m_data1_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_data1_ap);
        m_data2_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_data2_ap);
        m_immediate_data_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_immediate_data_ap);
        m_rd_in_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_rd_in_ap);
        m_rs1_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_rs1_ap);
        m_rs2_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_rs2_ap);
        m_ex_mem_rd_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_ex_mem_rd_ap);
        m_mem_wb_rd_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_mem_wb_rd_ap);
        m_ex_mem_RegWrite_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_ex_mem_RegWrite_ap);
        m_mem_wb_RegWrite_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_mem_wb_RegWrite_ap);
        m_forward_ex_mem_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_forward_ex_mem_ap);
        m_forward_mem_wb_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_forward_mem_wb_ap);
        m_control_out_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_control_out_ap);
        m_ZeroFlag_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_ZeroFlag_ap);
        m_alu_data_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_alu_data_ap);
        m_memory_data_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_memory_data_ap);
        m_rd_out_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_rd_out_ap);
        m_pc_out_agent.m_monitor.m_analysis_port.connect(m_scoreboard.m_pc_out_ap);

    endfunction : connect_phase

endclass : tb_env

//------------------------------------------------------------------------------
// top_config class
//
// Top level configuration object for top level component.
// This class is intended to be used by the UVM configuration database.
//
// It contains the configuration objects for each agent in the system and
// configures them appropriately for the test.
//
//------------------------------------------------------------------------------
class top_config extends uvm_object;
    `uvm_object_param_utils(top_config)
    // Adresses
    address_config     m_rd_in_config;
    address_config     m_rd_out_config;
    address_config     m_rs1_config;
    address_config     m_rs2_config;
    address_config     m_ex_mem_rd_config;
    address_config     m_mem_wb_rd_config;
    // clocks
    clock_config      m_clock_config;
    // controls
    control_config    m_control_in_config;
    control_config    m_control_out_config;
    // datas
    data_config       m_data1_config;
    data_config       m_data2_config;
    data_config       m_alu_data_config;
    data_config       m_memory_data_config;
    data_config       m_forward_ex_mem_config;
    data_config       m_forward_mem_wb_config;
    data_config       m_immediate_data_config;
    // pcs
    pc_config         m_pc_config;
    pc_config         m_pc_out_config;
    // RegWrites
    RegWrite_config   m_ex_mem_RegWrite_config;
    RegWrite_config   m_mem_wb_RegWrite_config;
    // ZeroFlags
    ZeroFlag_config   m_ZeroFlag_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new (string name="top_config");
        super.new(name);
        // Create and configure alu_data uVC configuration with driver and monitor
        m_alu_data_config = new("m_alu_data_config");
        m_alu_data_config.is_active = 0;
        m_alu_data_config.has_monitor = 1;
        // Create and configure clock uVC with 10ns clock generation
        m_clock_config = new("m_clock_config");
        m_clock_config.is_active = 1;
        m_clock_config.clock_period = 10;
        // Create and configure control_in uVC configuration with driver and monitor
        m_control_in_config = new("m_control_in_config");
        m_control_in_config.is_active = 1;
        m_control_in_config.has_monitor = 1;
        // Create and configure control_out uVC configuration with only monitor
        m_control_out_config = new("m_control_out_config");
        m_control_out_config.is_active = 0;
        m_control_out_config.has_monitor = 1;
        // Create and configure data1 uVC configuration with only monitor
        m_data1_config = new("m_data1_config");
        m_data1_config.is_active = 1;
        m_data1_config.has_monitor = 1;
        // Create and configure data2 uVC configuration with only monitor
        m_data2_config = new("m_data2_config");
        m_data2_config.is_active = 1;
        m_data2_config.has_monitor = 1;
        // Create and configure ex_mem_rd uVC configuration with only monitor
        m_ex_mem_rd_config = new("m_ex_mem_rd_config");
        m_ex_mem_rd_config.is_active = 1;
        m_ex_mem_rd_config.has_monitor = 1;
        // Create and configure ex_mem_RegWrite uVC configuration with only monitor
        m_ex_mem_RegWrite_config = new("m_ex_mem_RegWrite_config");
        m_ex_mem_RegWrite_config.is_active = 1;
        m_ex_mem_RegWrite_config.has_monitor = 1;
        // Create and configure forward_ex_mem uVC configuration with only monitor
        m_forward_ex_mem_config = new("m_forward_ex_mem_config");
        m_forward_ex_mem_config.is_active = 1;
        m_forward_ex_mem_config.has_monitor = 1;
        // Create and configure forward_mem_wb uVC configuration with only monitor
        m_forward_mem_wb_config = new("m_forward_mem_wb_config");
        m_forward_mem_wb_config.is_active = 1;
        m_forward_mem_wb_config.has_monitor = 1;
        // Create and configure immediate_data uVC configuration with only monitor
        m_immediate_data_config = new("m_immediate_data_config");
        m_immediate_data_config.is_active = 1;
        m_immediate_data_config.has_monitor = 1;
        // Create and configure mem_wb_rd uVC configuration with only monitor
        m_mem_wb_rd_config = new("m_mem_wb_rd_config");
        m_mem_wb_rd_config.is_active = 1;
        m_mem_wb_rd_config.has_monitor = 1;
        // Create and configure mem_wb_RegWrite uVC configuration with only monitor
        m_mem_wb_RegWrite_config = new("m_mem_wb_RegWrite_config");
        m_mem_wb_RegWrite_config.is_active = 1;
        m_mem_wb_RegWrite_config.has_monitor = 1;
        // Create and configure memory_data uVC configuration with only monitor
        m_memory_data_config = new("m_memory_data_config");
        m_memory_data_config.is_active = 0;
        m_memory_data_config.has_monitor = 1;
        // Create and configure pc_out uVC configuration with only monitor
        m_pc_out_config = new("m_pc_out_config");
        m_pc_out_config.is_active = 0;
        m_pc_out_config.has_monitor = 1;
        // Create and configure pc uVC configuration with only monitor
        m_pc_config = new("m_pc_config");
        m_pc_config.is_active = 1;
        m_pc_config.has_monitor = 1;
        // Create and configure rd_in uVC configuration with only monitor
        m_rd_in_config = new("m_rd_in_config");
        m_rd_in_config.is_active = 1;
        m_rd_in_config.has_monitor = 1;
        // Create and configure rd_out uVC configuration with only monitor
        m_rd_out_config = new("m_rd_out_config");
        m_rd_out_config.is_active = 0;
        m_rd_out_config.has_monitor = 1;
        // Create and configure rs1 uVC configuration with only monitor
        m_rs1_config = new("m_rs1_config");
        m_rs1_config.is_active = 1;
        m_rs1_config.has_monitor = 1;
        // Create and configure rs2 uVC configuration with only monitor
        m_rs2_config = new("m_rs2_config");
        m_rs2_config.is_active = 1;
        m_rs2_config.has_monitor = 1;
        // Create and configure ZeroFlag uVC configuration with only monitor
        m_ZeroFlag_config = new("m_ZeroFlag_config");
        m_ZeroFlag_config.is_active = 0;
        m_ZeroFlag_config.has_monitor = 1;
    endfunction : new

endclass : top_config

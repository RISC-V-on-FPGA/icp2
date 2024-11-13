//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
class mem_wb_RegWrite_driver extends uvm_driver;
    `uvm_component_utils(mem_wb_RegWrite_driver)

    // mem_wb_RegWrite uVC configuration object.
    mem_wb_RegWrite_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(mem_wb_RegWrite_config)::get(this,"","mem_wb_RegWrite_config", m_config)) begin
            `uvm_fatal(get_name(),"Cannot find the VC configuration!")
        end
    endfunction

    //------------------------------------------------------------------------------
    // The build phase for the component.
    //------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    //------------------------------------------------------------------------------
    // The run phase for the component.
    //------------------------------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        // Perform the requested action and send response back.
        `uvm_info("mem_wb_RegWrite_driver",$sformatf("Start mem_wb_RegWrite with  %0d", m_config.mem_wb_RegWrite),UVM_MEDIUM)
        // Reset signal
        m_config.m_vif.mem_wb_RegWrite <= 0;
        // Generate mem_wb_RegWrite
        forever begin
            m_config.m_vif.mem_wb_RegWrite <= m_config.m_vif.mem_wb_RegWrite;
        end
    endtask : run_phase

endclass : mem_wb_RegWrite_driver

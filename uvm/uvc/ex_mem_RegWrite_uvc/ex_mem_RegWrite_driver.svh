//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
class ex_mem_RegWrite_driver extends uvm_driver;
    `uvm_component_utils(ex_mem_RegWrite_driver)

    // ex_mem_RegWrite uVC configuration object.
    ex_mem_RegWrite_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(ex_mem_RegWrite_config)::get(this,"","ex_mem_RegWrite_config", m_config)) begin
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
        `uvm_info("ex_mem_RegWrite_driver",$sformatf("Start ex_mem_RegWrite with  %0d", m_config.ex_mem_RegWrite),UVM_MEDIUM)
        // Reset signal
        m_config.m_vif.ex_mem_RegWrite <= 0;
        // Generate ex_mem_RegWrite
        forever begin
            m_config.m_vif.ex_mem_RegWrite <= m_config.m_vif.ex_mem_RegWrite;
        end
    endtask : run_phase

endclass : ex_mem_RegWrite_driver

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
class control_in_driver extends uvm_driver;
    `uvm_component_utils(control_in_driver)

    // control_in uVC configuration object.
    control_in_config  m_config;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(control_in_config)::get(this,"","control_in_config", m_config)) begin
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
        `uvm_info("control_in_driver",$sformatf("Start control_in with period %0d", m_config.control_in_period),UVM_MEDIUM)
        // Reset signal
        // sätter OP = ADD -> encoding = I-type -> ALUSrc = 1 för immediate -> MemRead = 0 inte läsa minne -> MemWrite = 0 för inte läsa minne -> RegWrite = 1 vill skriva minne -> MemToreg = 0 -> IsBranch = 0 -> BranchType spelar ingen roll
        m_config.m_vif.control_in <= {4'b0100, 3'b001, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 3'b000};              //behövs detta, ger oss NOP instruction???????????????????????????
        // Generate control_in
        forever begin
            m_config.m_vif.control_in <= m_config.m_vif.control_in;
        end
    endtask : run_phase

endclass : control_in_driver

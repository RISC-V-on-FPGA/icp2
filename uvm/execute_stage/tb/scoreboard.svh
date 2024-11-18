
// Instance analysis defines
`uvm_analysis_imp_decl(_scoreboard_clk)
`uvm_analysis_imp_decl(_scoreboard_pc)
`uvm_analysis_imp_decl(_scoreboard_control_in)
`uvm_analysis_imp_decl(_scoreboard_data1)
`uvm_analysis_imp_decl(_scoreboard_data2)
`uvm_analysis_imp_decl(_scoreboard_immediate_data)
`uvm_analysis_imp_decl(_scoreboard_rd_in)
`uvm_analysis_imp_decl(_scoreboard_rs1)
`uvm_analysis_imp_decl(_scoreboard_rs2)
`uvm_analysis_imp_decl(_scoreboard_ex_mem_rd)
`uvm_analysis_imp_decl(_scoreboard_mem_wb_rd)
`uvm_analysis_imp_decl(_scoreboard_ex_mem_RegWrite)
`uvm_analysis_imp_decl(_scoreboard_mem_wb_RegWrite)
`uvm_analysis_imp_decl(_scoreboard_forward_ex_mem)
`uvm_analysis_imp_decl(_scoreboard_forward_mem_wb)
`uvm_analysis_imp_decl(_scoreboard_control_out)
`uvm_analysis_imp_decl(_scoreboard_ZeroFlag)
`uvm_analysis_imp_decl(_scoreboard_alu_data)
`uvm_analysis_imp_decl(_scoreboard_memory_data)
`uvm_analysis_imp_decl(_scoreboard_rd_out)
`uvm_analysis_imp_decl(_scoreboard_pc_out)
class scoreboard extends uvm_component;
    `uvm_component_utils(scoreboard)

    uvm_analysis_imp_scoreboard_clk #(clk_seq_item, scoreboard) m_clk_ap;
    uvm_analysis_imp_scoreboard_pc #(pc_seq_item, scoreboard) m_pc_ap;
    uvm_analysis_imp_scoreboard_control_in #(control_in_seq_item, scoreboard) m_control_in_ap;
    uvm_analysis_imp_scoreboard_data1 #(data1_seq_item, scoreboard) m_data1_ap;
    uvm_analysis_imp_scoreboard_data2 #(data2_seq_item, scoreboard) m_data2_ap;
    uvm_analysis_imp_scoreboard_immediate_data #(immediate_data_seq_item, scoreboard) m_immediate_data_ap;
    uvm_analysis_imp_scoreboard_rd_in #(rd_in_seq_item, scoreboard) m_rd_in_ap;
    uvm_analysis_imp_scoreboard_rs1 #(rs1_seq_item, scoreboard) m_rs1_ap;
    uvm_analysis_imp_scoreboard_rs2 #(rs2_seq_item, scoreboard) m_rs2_ap;
    uvm_analysis_imp_scoreboard_ex_mem_rd #(ex_mem_rd_seq_item, scoreboard) m_ex_mem_rd_ap;
    uvm_analysis_imp_scoreboard_mem_wb_rd #(mem_wb_rd_seq_item, scoreboard) m_mem_wb_rd_ap;
    uvm_analysis_imp_scoreboard_ex_mem_RegWrite #(ex_mem_RegWrite_seq_item, scoreboard) m_ex_mem_RegWrite_ap;
    uvm_analysis_imp_scoreboard_mem_wb_RegWrite #(mem_wb_RegWrite_seq_item, scoreboard) m_mem_wb_RegWrite_ap;
    uvm_analysis_imp_scoreboard_forward_ex_mem #(forward_ex_mem_seq_item, scoreboard) m_forward_ex_mem_ap;
    uvm_analysis_imp_scoreboard_control_out #(control_out_seq_item, scoreboard) m_control_out_ap;
    uvm_analysis_imp_scoreboard_ZeroFlag #(ZeroFlag_seq_item, scoreboard) m_ZeroFlag_ap;
    uvm_analysis_imp_scoreboard_alu_data #(alu_data_seq_item, scoreboard) m_alu_data_ap;
    uvm_analysis_imp_scoreboard_memory_data #(memory_data_seq_item, scoreboard) m_memory_data_ap;
    uvm_analysis_imp_scoreboard_rd_out #(rd_out_seq_item, scoreboard) m_rd_out_ap;
    uvm_analysis_imp_scoreboard_pc_out #(pc_out_seq_item, scoreboard) m_pc_out_ap;

    int unsigned clk;
    int unsigned pc;
    int unsigned control_in;
    int unsigned data1;
    int unsigned data2;
    int unsigned immediate_data;
    int unsigned rd_in;
    int unsigned rs1;
    int unsigned rs2;
    int unsigned ex_mem_rd;
    int unsigned mem_wb_rd;
    int unsigned ex_mem_RegWrite;
    int unsigned mem_wb_RegWrite;
    int unsigned forward_ex_mem;
    int unsigned forward_mem_wb;
    int unsigned control_out;
    int unsigned ZeroFlag;
    int unsigned alu_data;
    int unsigned memory_data;
    int unsigned rd_out;
    int unsigned pc_out;

    //------------------------------------------------------------------------------
    // Functional coverage definitions
    //------------------------------------------------------------------------------
    covergroup execute_stage_covergrp;
        // TODO
    endgroup

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name = "scoreboard", uvm_component parent = null);
        super.new(name,parent);
        // Create coverage group
        execute_stage_covergrp = new();
    endfunction : new

    //------------------------------------------------------------------------------
    // The build for the component.
    //------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Create analysis connections
        m_clk_ap = new("m_clk_ap", this);
        m_pc_ap = new("m_pc_ap", this);
        m_control_in_ap = new("m_control_in_ap", this);
        m_data1_ap = new("m_data1_ap", this);
        m_data2_ap = new("m_data2_ap", this);
        m_immediate_data_ap = new("m_immediate_data_ap", this);
        m_rd_in_ap = new("m_rd_in_ap", this);
        m_rs1_ap = new("m_rs1_ap", this);
        m_rs2_ap = new("m_rs2_ap", this);
        m_ex_mem_rd_ap = new("m_ex_mem_rd_ap", this);
        m_mem_wb_rd_ap = new("m_mem_wb_rd_ap", this);
        m_ex_mem_RegWrite_ap = new("m_ex_mem_RegWrite_ap", this);
        m_mem_wb_RegWrite_ap = new("m_mem_wb_RegWrite_ap", this);
        m_forward_ex_mem_ap = new("m_forward_ex_mem_ap", this);
        m_control_out_ap = new("m_control_out_ap", this);
        m_ZeroFlag_ap = new("m_ZeroFlag_ap", this);
        m_alu_data_ap = new("m_alu_data_ap", this);
        m_memory_data_ap = new("m_memory_data_ap", this);
        m_rd_out_ap = new("m_rd_out_ap", this);
        m_pc_out_ap = new("m_pc_out_ap", this);

    endfunction : build_phase

    //------------------------------------------------------------------------------
    // The connection phase for the component.
    //------------------------------------------------------------------------------
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

    //------------------------------------------------------------------------------
    // Write implementations
    //------------------------------------------------------------------------------
    virtual function void write_pc(clk_seq_item item);
        `uvm_info(get_name(),$sformatf("PC_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        pc = item.pc;
        execute_stage_covergrp.sample();
    endfunction :  write_pc
    
    //------------------------------------------------------------------------------
    // Check data if both input serial data and output data are valid.
    //------------------------------------------------------------------------------
    virtual function void check_data();
        // Both serial data and parallel data need to valid before check the DUT data and parity error
        if (input_data_valid && dut_data_valid) begin
            // Check DUT data is correct
            if (dut_data != input_data) begin
                `uvm_error(get_name(), $sformatf("Data mismatch!!! Received data=%08b(%0d) Expected data=%08b(%0d)", dut_data, dut_data, input_data, input_data))
            end
            else begin
                `uvm_info(get_name(),$sformatf("Received complete 8 data bits as expected. Data=%0d", dut_data), UVM_MEDIUM)
            end
            data_checked++;
            // Check DUT parity error is correct
            if (dut_parity_error != input_parity_error) begin
                `uvm_error(get_name(), $sformatf("Parity error mismatch!!! Received parity error=%0s Expected=%0s", (dut_parity_error ? "PARITY_ERROR" : "OK"), input_parity_error ? "PARITY_ERROR" : "OK"))
            end
            // Clear valid to indicate the data and parity has been checked
            input_data_valid= 0;
            dut_data_valid= 0;
        end
    endfunction :  check_data

    //------------------------------------------------------------------------------
    // UVM check phase
    //------------------------------------------------------------------------------
    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);
        // Complete simulation
        $display("*****************************************************");
        $display("Number of checked data %0d", data_checked);
        $display("*****************************************************");
        if (serial_to_parallel_covergrp.get_coverage() == 100.0) begin
            $display("FUNCTIONAL COVERAGE (100.0%%) PASSED....");
        end
        else begin
            $display("FUNCTIONAL COVERAGE FAILED!!!!!!!!!!!!!!!!!");
            $display("Coverage = %0f", serial_to_parallel_covergrp.get_coverage());
        end
        $display("*****************************************************");
    endfunction : check_phase

endclass : scoreboard

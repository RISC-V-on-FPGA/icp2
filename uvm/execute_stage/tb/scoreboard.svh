
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

    uvm_analysis_imp_scoreboard_pc #(pc_seq_item, scoreboard) m_pc_ap;
    uvm_analysis_imp_scoreboard_control_in #(control_seq_item, scoreboard) m_control_in_ap;
    uvm_analysis_imp_scoreboard_data1 #(data_seq_item, scoreboard) m_data1_ap;
    uvm_analysis_imp_scoreboard_data2 #(data_seq_item, scoreboard) m_data2_ap;
    uvm_analysis_imp_scoreboard_immediate_data #(data_seq_item, scoreboard) m_immediate_data_ap;
    uvm_analysis_imp_scoreboard_rd_in #(address_seq_item, scoreboard) m_rd_in_ap;
    uvm_analysis_imp_scoreboard_rs1 #(address_seq_item, scoreboard) m_rs1_ap;
    uvm_analysis_imp_scoreboard_rs2 #(address_seq_item, scoreboard) m_rs2_ap;
    uvm_analysis_imp_scoreboard_ex_mem_rd #(address_seq_item, scoreboard) m_ex_mem_rd_ap;
    uvm_analysis_imp_scoreboard_mem_wb_rd #(address_seq_item, scoreboard) m_mem_wb_rd_ap;
    uvm_analysis_imp_scoreboard_ex_mem_RegWrite #(RegWrite_seq_item, scoreboard) m_ex_mem_RegWrite_ap;
    uvm_analysis_imp_scoreboard_mem_wb_RegWrite #(RegWrite_seq_item, scoreboard) m_mem_wb_RegWrite_ap;
    uvm_analysis_imp_scoreboard_forward_ex_mem #(data_seq_item, scoreboard) m_forward_ex_mem_ap;
    uvm_analysis_imp_scoreboard_forward_mem_wb #(data_seq_item, scoreboard) m_forward_mem_wb_ap;
    uvm_analysis_imp_scoreboard_control_out #(control_seq_item, scoreboard) m_control_out_ap;
    uvm_analysis_imp_scoreboard_ZeroFlag #(ZeroFlag_seq_item, scoreboard) m_ZeroFlag_ap;
    uvm_analysis_imp_scoreboard_alu_data #(data_seq_item, scoreboard) m_alu_data_ap;
    uvm_analysis_imp_scoreboard_memory_data #(data_seq_item, scoreboard) m_memory_data_ap;
    uvm_analysis_imp_scoreboard_rd_out #(address_seq_item, scoreboard) m_rd_out_ap;
    uvm_analysis_imp_scoreboard_pc_out #(pc_seq_item, scoreboard) m_pc_out_ap;

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

    int unsigned MAX_VALUE_32 = 4294967295;
    int unsigned MAX_VALUE_5 = 31;  

    //------------------------------------------------------------------------------
    // Functional coverage definitions
    //------------------------------------------------------------------------------
    covergroup execute_stage_covergrp;
        // PC sequence coverage
        pc : coverpoint pc {
            bins pc_min = {0};
            bins pc_max = {MAX_VALUE_32};
            bins pc_100_in_between[100] = {[0:$]};
        }

        // Control sequence coverage with multiple hit counts
        control_in : coverpoint control_in {
            bins ALUop = {4'b0000, 4'b0001, 4'b0010, 4'b0100, 4'b0101, 4'b0110,
                        4'b1000, 4'b1001, 4'b1010, 4'b1100, 4'b1101};
            bins ALUop_hit10[5] = {4'b0000, 4'b0001, 4'b0010, 4'b0100, 4'b0101, 4'b0110,
                                4'b1000, 4'b1001, 4'b1010, 4'b1100, 4'b1101};
            bins encoding = {0, 1, 2, 3, 4, 5, 6};
            bins ALUsrc = {0, 1};
            bins MemRead = {0, 1};
            bins MemWrite = {0, 1};
            bins RegWrite = {0, 1};
            bins MemtoReg = {0, 1};
            bins is_branch = {0, 1};
            bins BranchType = {0, 1, 2, 3, 4, 5, 6};
        }

        // Data sequences coverage
        data1 : coverpoint data1 {
            bins data1_min = {0};
            bins data1_max = {MAX_VALUE_32};
            bins data1_100_in_between = {[1:$]};
            illegal_bins bad = default;
        }

        data2 : coverpoint data2 {
            bins data2_min = {0};
            bins data2_max = {MAX_VALUE_32};
            bins data2_100_in_between[10] = {[1:$]};
            illegal_bins bad = default;
        }
        immediate_data : coverpoint immediate_data {
            bins immediate_min = {0};
            bins immediate_max = {MAX_VALUE_32};
            bins immediate_100_in_between[100] = {[1:$]};
        }
        forward_ex_mem : coverpoint forward_ex_mem {
            bins forward_ex_mem_min = {0};
            bins forward_ex_mem_max = {MAX_VALUE_32};
            bins forward_ex_mem_100_in_between[100] = {[1:$]};
        }
        forward_mem_wb : coverpoint forward_mem_wb {
            bins forward_mem_wb_min = {0};
            bins forward_mem_wb_max = {MAX_VALUE_32};
            bins forward_mem_wb_100_in_between[100] = {[1:$]};
        }

        // Address sequences coverage
        rd_in : coverpoint rd_in {
            bins rd_in_min = {0};
            bins rd_in_max = {MAX_VALUE_5};
            bins rd_in_100_in_between[100] = {[1:$]};
        }
        rs1 : coverpoint rs1 {
            bins rs1_min = {0};
            bins rs1_max = {MAX_VALUE_5};
            bins rs1_100_in_between[100] = {[1:$]};
        }
        rs2 : coverpoint rs2 {
            bins rs2_min = {0};
            bins rs2_max = {MAX_VALUE_5};
            bins rs2_100_in_between[100] = {[1:$]};
        }
        ex_mem_rd : coverpoint ex_mem_rd {
            bins ex_mem_rd_min = {0};
            bins ex_mem_rd_max = {MAX_VALUE_5};
            bins ex_mem_rd_100_in_between[100] = {[1:$]};
        }
        mem_wb_rd : coverpoint mem_wb_rd {
            bins mem_wb_rd_min = {0};
            bins mem_wb_rd_max = {MAX_VALUE_5};
            bins mem_wb_rd_100_in_between[100] = {[1:$]};
        }

        // RegWrite sequences coverage
        ex_mem_RegWrite : coverpoint ex_mem_RegWrite {
            bins ex_mem_RegWrite_0 = {0};
            bins ex_mem_RegWrite_1 = {1};
        }
        mem_wb_RegWrite : coverpoint mem_wb_RegWrite {
            bins mem_wb_RegWrite_0 = {0};
            bins mem_wb_RegWrite_1 = {1};
        }        
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
        m_forward_mem_wb_ap = new("m_forward_mem_wb_ap", this);
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
    virtual function void write_scoreboard_pc(pc_seq_item item);
        `uvm_info(get_name(),$sformatf("PC_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        pc = item.pc;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_pc
    
    virtual function void write_scoreboard_control_in(control_seq_item item);
        `uvm_info(get_name(),$sformatf("control_in_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        control_in = item.control;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_control_in

    virtual function void write_scoreboard_data1(data_seq_item item);
        `uvm_info(get_name(),$sformatf("data1_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        data1 = item.data;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_data1

    virtual function void write_scoreboard_data2(data_seq_item item);
        `uvm_info(get_name(),$sformatf("data2_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        data2 = item.data;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_data2

    virtual function void write_scoreboard_immediate_data(data_seq_item item);
        `uvm_info(get_name(),$sformatf("immediate_data_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        immediate_data = item.data;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_immediate_data

    virtual function void write_scoreboard_rd_in(address_seq_item item);
        `uvm_info(get_name(),$sformatf("rd_in_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        rd_in = item.address;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_rd_in

    virtual function void write_scoreboard_rs1(address_seq_item item);
        `uvm_info(get_name(),$sformatf("rs1_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        rs1 = item.address;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_rs1

    virtual function void write_scoreboard_rs2(address_seq_item item);
        `uvm_info(get_name(),$sformatf("rs2_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        rs2 = item.address;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_rs2

    virtual function void write_scoreboard_ex_mem_rd(address_seq_item item);
        `uvm_info(get_name(),$sformatf("ex_mem_rd_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        ex_mem_rd = item.address;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_ex_mem_rd

    virtual function void write_scoreboard_mem_wb_rd(address_seq_item item);
        `uvm_info(get_name(),$sformatf("mem_wb_rd_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        mem_wb_rd = item.address;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_mem_wb_rd

    virtual function void write_scoreboard_ex_mem_RegWrite(RegWrite_seq_item item);
        `uvm_info(get_name(),$sformatf("ex_mem_RegWrite_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        ex_mem_RegWrite = item.RegWrite;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_ex_mem_RegWrite

    virtual function void write_scoreboard_mem_wb_RegWrite(RegWrite_seq_item item);
        `uvm_info(get_name(),$sformatf("mem_wb_RegWrite_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        mem_wb_RegWrite = item.RegWrite;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_mem_wb_RegWrite

    virtual function void write_scoreboard_forward_ex_mem(data_seq_item item);
        `uvm_info(get_name(),$sformatf("forward_ex_mem_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        forward_ex_mem = item.data;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_forward_ex_mem

    virtual function void write_scoreboard_forward_mem_wb(data_seq_item item);
        `uvm_info(get_name(),$sformatf("forward_mem_wb_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        forward_mem_wb = item.data;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_forward_mem_wb

    virtual function void write_scoreboard_control_out(control_seq_item item);
        `uvm_info(get_name(),$sformatf("control_out_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        control_out = item.control;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_control_out

    virtual function void write_scoreboard_ZeroFlag(ZeroFlag_seq_item item);
        `uvm_info(get_name(),$sformatf("ZeroFlag_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        ZeroFlag = item.ZeroFlag;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_ZeroFlag

    virtual function void write_scoreboard_alu_data(data_seq_item item);
        `uvm_info(get_name(),$sformatf("alu_data_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        alu_data = item.data;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_alu_data

    virtual function void write_scoreboard_memory_data(data_seq_item item);
        `uvm_info(get_name(),$sformatf("memory_data_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        memory_data = item.data;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_memory_data

    virtual function void write_scoreboard_rd_out(address_seq_item item);
        `uvm_info(get_name(),$sformatf("rd_out_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        rd_out = item.address;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_rd_out

    virtual function void write_scoreboard_pc_out(pc_seq_item item);
        `uvm_info(get_name(),$sformatf("pc_out_MONITOR:\n%s",item.sprint()),UVM_HIGH)
        pc_out = item.pc;
        execute_stage_covergrp.sample();
    endfunction :  write_scoreboard_pc_out


    //------------------------------------------------------------------------------
    // Check data if both input serial data and output data are valid.
    //------------------------------------------------------------------------------
    virtual function void check_data();

        if (pc_out != pc) begin
            `uvm_error(get_name(), $sformatf("PC is not forwared correctly, pc=%0d, pc_out=%0d", pc, pc_out))
        end

    endfunction :  check_data

    //------------------------------------------------------------------------------
    // UVM check phase
    //------------------------------------------------------------------------------
    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);
        // Complete simulation
        $display("*****************************************************");
        //$display("Number of checked data %0d", data_checked);
        $display("*****************************************************");
        if (execute_stage_covergrp.get_coverage() == 100.0) begin
            $display("FUNCTIONAL COVERAGE (100.0%%) PASSED....");
        end
        else begin
            $display("FUNCTIONAL COVERAGE FAILED!!!!!!!!!!!!!!!!!");
            $display("Coverage = %0f", execute_stage_covergrp.get_coverage());
        end
        $display("*****************************************************");
    endfunction : check_phase

endclass : scoreboard

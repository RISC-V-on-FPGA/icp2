vlog -sv -timescale 1ns/1ns +acc=pr \
        +incdir+uvc/clock_uvc+uvc/alu_data_uvc+uvc/control_in_uvc+uvc/control_out_uvc+uvc/data1_uvc+uvc/data2_uvc+uvc/ex_mem_rd_uvc+uvc/ex_mem_RegWrite_uvc+uvc/forward_ex_mem_uvc+uvc/forward_mem_wb_uvc+uvc/immediate_data_uvc+uvc/mem_wb_rd_uvc+uvc/mem_wb_RegWrite_uvc+uvc/memory_data_uvc+uvc/pc_out_uvc+uvc/pc_uvc+uvc/rd_in_uvc+uvc/rd_out_uvc+uvc/rs1_uvc+uvc/rs2_uvc+uvc/ZeroFlag_uvc+execute_stage/tb \
        uvc/clock_uvc/clock_if.sv uvc/alu_data_uvc/alu_data_if.sv uvc/control_in_uvc/control_in_if.sv uvc/control_out_uvc/control_out_if.sv uvc/data1_uvc/data1_if.sv uvc/data2_uvc/data2_if.sv uvc/ex_mem_rd_uvc/ex_mem_rd_if.sv uvc/ex_mem_RegWrite_uvc/ex_mem_RegWrite_if.sv uvc/forward_ex_mem_uvc/forward_ex_mem_if.sv uvc/forward_mem_wb_uvc/forward_mem_wb_if.sv uvc/immediate_data_uvc/immediate_data_if.sv uvc/mem_wb_rd_uvc/mem_wb_rd_if.sv uvc/mem_wb_RegWrite_uvc/mem_wb_RegWrite_if.sv uvc/memory_data_uvc/memory_data_if.sv uvc/pc_out_uvc/pc_out_if.sv uvc/pc_uvc/pc_if.sv uvc/rd_in_uvc/rd_in_if.sv uvc/rd_out_uvc/rd_out_if.sv uvc/rs1_uvc/rs1_if.sv uvc/rs2_uvc/rs2_if.sv uvc/ZeroFlag_uvc/ZeroFlag_if.sv \
        execute_stage/dut/common.sv execute_stage/dut/alu.sv execute_stage/dut/forwarding_unit.sv execute_stage/dut/execute_stage.sv execute_stage/tb/tb_pkg.sv execute_stage/tb/tb_top.sv
vsim  -i work.tb_top -coverage +UVM_NO_RELNOTES +UVM_VERBOSITY=UVM_HIGH +UVM_TESTNAME=basic_test
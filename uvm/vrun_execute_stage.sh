# Clear terminal in QuestaSim
.main clear

# Compile the design and testbench
vlog -sv -timescale 1ns/1ns +acc=pr \
        +incdir+uvc/clock_uvc+uvc/address_uvc+uvc/control_uvc+uvc/data_uvc+uvc/pc_uvc+uvc/RegWrite_uvc+uvc/ZeroFlag_uvc+execute_stage/tb \
        uvc/clock_uvc/clock_if.sv  uvc/address_uvc/address_if.sv uvc/control_uvc/control_if.sv uvc/data_uvc/data_if.sv uvc/pc_uvc/pc_if.sv uvc/RegWrite_uvc/RegWrite_if.sv uvc/ZeroFlag_uvc/ZeroFlag_if.sv \
        execute_stage/dut/common.sv execute_stage/dut/alu.sv execute_stage/dut/forwarding_unit.sv execute_stage/dut/execute_stage.sv execute_stage/tb/tb_pkg.sv execute_stage/tb/tb_top.sv

# Launch simulation
vsim -i work.tb_top -coverage +UVM_NO_RELNOTES +UVM_VERBOSITY=UVM_HIGH +UVM_TESTNAME=basic_test -do "run 1us"

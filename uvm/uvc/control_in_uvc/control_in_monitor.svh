//------------------------------------------------------------------------------
// control_in class
//
// This class is the monitor for serial data interface.
//
// This task monitors the serial interface for start bit, serial data bits, and parity bit.
// It monitors the start_bit and serial data signals. Before the monitor starts it waits
// for reset is released and every time reset is activated it reset the monitor state.
//
// It then creates a sequence item from the monitored data and writes it to the analysis port.
//
//------------------------------------------------------------------------------
class control_in_monitor  extends uvm_monitor;
    `uvm_component_param_utils(control_in_monitor)

    // control_in uVC configuration object.
    control_in_config  m_config;
    // Monitor analysis port.
    uvm_analysis_port #(control_in_seq_item)  m_analysis_port;

    //------------------------------------------------------------------------------
    // The constructor for the component.
    //------------------------------------------------------------------------------
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        if (!uvm_config_db #(control_in_config)::get(this,"","control_in_config", m_config)) begin
            `uvm_fatal(get_name(),"Cannot find the VC configuration!")
        end
        m_analysis_port = new("m_control_in_analysis_port", this);
    endfunction

    //------------------------------------------------------------------------------
    // The build phase for the component.
    //------------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    //------------------------------------------------------------------------------
    // The run phase for the monitor.
    //------------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        process check_process;
        bit[31:0] rec_data;     // stämmer detta eller skall det egentligen vara en "control_type" -> vi har ju: "rand bit [31:0] control_in;" fårn seq item filen???????

        `uvm_info(get_name(),$sformatf("Starting serial interface monitoring"),UVM_HIGH)
        fork
            // Monitoring start bit
            forever begin
                control_in_seq_item seq_item;
                logic start_bit;
                
                start_bit = m_config.m_vif.start_bit;
                @(negedge m_config.m_vif.clk);
                // Wait for start bit is changed
                while (start_bit == m_config.m_vif.start_bit) begin
                    @(negedge m_config.m_vif.clk);
                end
                // Create a new reset sequence item
                seq_item = control_in_seq_item::type_id::create("seq_item");
                seq_item.monitor_start_bit_value = m_config.m_vif.start_bit;
                seq_item.monitor_start_bit_valid = 1;
                // Write to analysis port
                m_analysis_port.write(seq_item);
            end
            // Monitoring serial data bit
            forever begin
                // Wait for reset to be released
                `uvm_info(get_name(),$sformatf("Waiting for reset signal is released..."),UVM_HIGH)
                @(posedge m_config.m_vif.rst_n);
                @(negedge m_config.m_vif.clk);
                `uvm_info(get_name(),$sformatf("Reset signal is released"),UVM_HIGH)
                fork
                    // Detect reset during testing
                    begin
                        @(negedge m_config.m_vif.rst_n);
                        `uvm_info(get_name(),$sformatf("Reset detected. Checking aborted!!"),UVM_HIGH)
                        if (check_process != null) begin
                            check_process.kill();
                        end
                    end
                    // Checking the control_in on the m_vif
                    forever begin
                        control_in_seq_item  seq_item;
                        bit[31:0] control_in;

                        check_process = process::self();        
                        control_in = m_config.m_vif.control_in; // samplar det som finns på vårt interface
                        `uvm_info(get_name(),$sformatf("Received control_in=%0d", m_config.m_vif.control_in),UVM_HIGH) // kod for utskrift?????

                        




                        // givet från serial_data
                        // int bits;
                        // bit parity_error;
                        // bits = (m_config.parity_enable ? 9 : 8);
                        // // bits = 8;
                        // // check_process = process::self();
                        // for (int nn=0; nn<bits; nn++) begin
                        //     // Wait for start bit to be set
                        //     if (nn==0) begin
                        //         if (m_config.m_vif.start_bit==0) begin
                        //             `uvm_info(get_name(),$sformatf("Wait for start bit....."),UVM_HIGH)
                        //             @(posedge m_config.m_vif.start_bit);
                        //             @(negedge m_config.m_vif.clk);
                        //         end
                        //         rec_data= 0;
                        //         `uvm_info(get_name(),$sformatf("Received start bit"),UVM_HIGH)
                        //     end
                        //     if (nn < 8) begin
                        //         // Store received serial data bit
                        //         rec_data[nn]= m_config.m_vif.control_in;
                        //         `uvm_info(get_name(),$sformatf("Received bitno=%0d value=%0d", nn, m_config.m_vif.control_in),UVM_HIGH)
                        //     end
                        //     else begin
                        //         // Calculate parity error based on received serial parity bit
                        //         //Task 5: When everything looks good, Uncomment this!
                        //         parity_error = ($countones(rec_data) + m_config.m_vif.control_in) & 1;
                        //         `uvm_info(get_name(),$sformatf("Received bitno=%0d parity=%0d", nn, m_config.m_vif.control_in),UVM_HIGH)
                        //     end
                        //     @(negedge m_config.m_vif.clk);
                        //     if (nn==(bits-1)) begin
                        //         // Create a new control_in sequence item with expected data
                        //         `uvm_info(get_name(),$sformatf("Predict data output value=%0d", rec_data),UVM_HIGH)
                        //         seq_item = control_in_seq_item::type_id::create("seq_item");
                        //         seq_item.control_in= rec_data;
                        //         //Task 5: And this!
                        //         #1ns;
                        //         seq_item.parity_error= parity_error;
                        //         seq_item.monitor_data_valid = 1;
                        //         m_analysis_port.write(seq_item);
                        //     end
                        // end
                    end
                join_any
            end
        join
    endtask : run_phase
endclass : control_in_monitor

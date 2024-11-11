// reference_model.cpp

#include <iostream>
#include <vector>
#include "execute_stage.h"

// Example class for the reference model
class ExecuteStage {
public:
    ExecuteStage() : state(0) {}

    // Initialize the model
    void initialize() {
        state = 0;
        std::cout << "Reference model initialized." << std::endl;
    }

    // Process data: an example function that performs some computation
    int process(int input) {
        state += input;
        int output = state * 2;  // Example transformation
        std::cout << "Processing input: " << input << ", output: " << output << std::endl;
        return output;
    }

    // Finalize or clean up the model
    void finalize() {
        std::cout << "Reference model finalized. Final state: " << state << std::endl;
    }

private:
    int state;
};

// Global instance of the ReferenceModel
ExecuteStage model;

// Extern "C" functions for DPI-C access

// Function to initialize the model
extern "C" void initialize_model() {
    model.initialize();
}

// Function to process data, receiving input from SystemVerilog and returning output
extern "C" int process_data(int input) {
    return model.process(input);
}

// Function to finalize the model
extern "C" void finalize_model() {
    model.finalize();
}

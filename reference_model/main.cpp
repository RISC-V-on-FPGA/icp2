#include <iostream>
#include "execute_stage.h"  // Include your reference model file

int main() {
    // Initialize the model
    std::cout << "Initializing the reference model..." << std::endl;
    initialize_model();

    // Test the process_data function with some example inputs
    int input1 = 10;
    int output1 = process_data(input1);
    std::cout << "Input: " << input1 << ", Output: " << output1 << std::endl;

    int input2 = 20;
    int output2 = process_data(input2);
    std::cout << "Input: " << input2 << ", Output: " << output2 << std::endl;

    int input3 = -5;
    int output3 = process_data(input3);
    std::cout << "Input: " << input3 << ", Output: " << output3 << std::endl;

    // Finalize the model
    std::cout << "Finalizing the reference model..." << std::endl;
    finalize_model();

    return 0;
}

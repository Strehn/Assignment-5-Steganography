/* 
Name
Date
Course
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "steganography.h"
#include "ppm.h"

void print_usage() {
    printf("Usage:\n");
    printf("  Encode: ./steganography encode input.ppm payload.ext output.ppm\n");
    printf("  Decode: ./steganography decode input.ppm output.ext\n");
}

int main(int argc, char *argv[]) {
    // Check if the number of arguments is correct
    if (argc < 4) {
        print_usage();
        return EXIT_FAILURE;
    }

    // Parse the command-line arguments
    if (strcmp(argv[1], "encode") == 0) {
        // Ensure there are exactly 4 arguments for encoding
        if (argc != 4) {
            print_usage();
            return EXIT_FAILURE;
        }

        const char *input_ppm = argv[2];    // Input PPM file
        const char *payload_file = argv[3];  // Payload file (could be text or binary)
        const char *output_ppm = argv[4];    // Output PPM file with hidden message

        // Call the encode function (to be implemented)
        encode_message(input_ppm, payload_file, output_ppm);
    } 
    else if (strcmp(argv[1], "decode") == 0) {
        // Ensure there are exactly 3 arguments for decoding
        if (argc != 4) {
            print_usage();
            return EXIT_FAILURE;
        }
       const char *input_ppm = argv[2];   // Input PPM file with hidden message
        const char *output_file = argv[3];  // Output file to store decoded message

        // Call the decode function (to be implemented)
        decode_message(input_ppm, output_file);
    } 
    else {
        // If the user provides an invalid option
        print_usage();
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

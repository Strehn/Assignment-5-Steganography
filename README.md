# Background
Steganography is the art of concealing secret information within a non-suspicious file or medium. Unlike cryptography, which focuses on the protection of data through encryption, steganography seeks to hide the existence of the message itself. It can be thought of as a way of "sneaking" a message past potential adversaries, often in formats such as images, audio files, or text.

Historically, steganography has been used in various forms, such as encoding messages on hidden scrolls or shaving the head of a messenger to inscribe a message onto the scalp. In modern times, steganography is often used to hide messages in digital files, such as images or videos.

In this assignment, you will implement a simple form of steganography that encodes and decodes messages within an image file using the PPM (Portable Pixmap) format.

# PPM Image Format
The PPM format is a simple, uncompressed image format. For this assignment, we will use the ASCII version of PPM for color images with 24-bit color depth (RGB). Each pixel is represented by three 8-bit values (one for red, green, and blue).

Here is the structure of a PPM image:

P3 # Magic number indicating PPM format width height
# Width and height of the image 255
# Maximum color value R G B # RGB values for each pixel (row-major order)
For example, a 3x2 image would look like:

P3 3 2 255 255 0 0 0 255 0 0 0 255 255 255 0 255 255 255 0 0 0
Each RGB component is an integer in the range of 0 to 255.

# Your Program
You will write a C program that can encode and decode messages within a PPM image. The encoding will use the least significant bits (LSBs) of the green and blue components of each pixel to hide the bits of the message.

Program Modes
Your program should operate in two modes:

Encode mode: ./steganography encode input.ppm payload.ext output.ppm

Decode mode: ./steganography decode input.ppm output.ext

Encoding Process
Payload: The payload is the message (binary or plain text) you want to hide within the image. The first 16 bits of the payload will store the size of the message (in bytes). The remaining bits will represent the actual content of the message.

Encoding Logic:

For each pixel, the green and blue values will have their least significant bits (LSBs) modified to encode the payload bit by bit.

Specifically, the exclusive-or (XOR) of the LSBs of green and blue will be used to encode a message bit. If the XOR is 1, the bit will be set to 1, otherwise, it will be set to 0.

The image pixels will be modified row by row, and each pixel will hide 1 bit of the message.

PPM Header: You must ensure that the encoded image retains the original PPM header intact (format P3, width, height, and 255 max value).

Decoding Process
Decoding Logic:

To decode the message, you will reverse the encoding process.

By reading each pixel’s green and blue components, you will extract the LSBs and XOR them to reconstruct each bit of the payload.

Message Retrieval:

The first 16 bits represent the size of the message.

After that, the remaining bits will be the actual message data. You need to save this data in the appropriate output file (binary or text).

Error Handling
Your program should handle several possible error conditions:

Duplicate filenames: If any of the filenames provided (input, payload, or output) are the same, print an error message and terminate the program.

Payload too large: If the payload is too large to fit into the image (based on the number of pixels), print an error message.

PPM format validation: Ensure that the input PPM is in the correct format (i.e., "P3", valid width, height, and 255 max color depth). If the format is invalid, print an error message.

Partial decoding: If the encoded size is larger than the available pixels, handle the case by printing an error and possibly producing partial data.

# Program Structure
Your program should be divided into logical components across multiple files:

main.c: Handle user input, processing the command line, and calling the encoding or decoding functions.

ppm.c: Functions for reading and writing PPM images.

steganography.c: Functions for encoding and decoding the hidden messages.

utils.c: Helper functions (e.g., bit manipulation, error handling).

steganography.h: Header file for function prototypes.

ppm.h: Header file for reading and writing PPM files.

utils.h: Header file for utility functions.

# Suggested Functions
void encode_message(const char *input_ppm, const char *payload_file, const char *output_ppm);

void decode_message(const char *input_ppm, const char *output_file);

void write_ppm(const char *filename, ppm_image *image);

ppm_image *read_ppm(const char *filename);

void encode_bit_in_pixel(ppm_pixel *pixel, bool bit);

bool extract_bit_from_pixel(const ppm_pixel *pixel);

void xor_bit_in_pixel(ppm_pixel *pixel, bool bit);

void encode_size_in_header(ppm_image *image, uint16_t size);

# Hints
PPM File Reading/Writing: Use fscanf and fprintf to read and write the PPM file format.

File Operations: Use fread and fwrite to handle reading and writing binary files (for the payload).

Bit Manipulation: You can use bitwise operators (&, |, ^, ~) to manipulate bits in the RGB components of each pixel.

Command-Line Arguments: Parse the command-line arguments to identify whether the user wants to encode or decode the message.

Utility Functions: Consider creating utility functions for tasks such as checking if a file exists, validating input, or performing bit manipulation.

Example Run
Encode:

$ ./steganography encode input.ppm secret_message.txt output.ppm
Decode:

$ ./steganography decode input.ppm extracted_message.txt

# Additional Enhancements
Efficiency: You can optimize the encoding process by managing memory more efficiently or using buffers to avoid frequent file I/O.

Error Handling: Consider using errno or custom error codes for better error reporting.

Performance: Test your program with larger images and payloads to ensure it handles edge cases properly (e.g., small images, very large payloads).

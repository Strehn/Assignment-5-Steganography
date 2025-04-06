#!/bin/bash

# Test encoding and decoding with valid files

# Create a sample PPM image for testing
echo "P3
3 2
255
255 0 0
0 255 0
0 0 255
255 255 0
255 255 255
0 0 0" > test_input.ppm

# Create a sample payload for testing
echo "This is a secret message" > test_payload.txt

# Test encoding (normal case)
echo "Running encoding test with a text payload..."
./steganography encode test_input.ppm test_payload.txt test_encoded.ppm
if [ $? -eq 0 ]; then
    echo "Encoding test passed."
else
    echo "Encoding test failed."
fi

# Test decoding (normal case)
echo "Running decoding test with a text payload..."
./steganography decode test_encoded.ppm test_decoded.txt
if [ $? -eq 0 ]; then
    echo "Decoding test passed."
else
    echo "Decoding test failed."
fi

# Check if the decoded message is correct
echo "Verifying decoded text payload..."
if cmp -s test_payload.txt test_decoded.txt; then
    echo "Payload match: Decoding successful!"
else
    echo "Decoded message does not match payload!"
fi

# Test with a larger payload (text)
echo "Running encoding test with a larger text payload..."
echo "This is a much longer message to test the encoding and decoding capabilities of the steganography program. It will test if the program can handle payloads that are much larger than the original example." > large_payload.txt
./steganography encode test_input.ppm large_payload.txt test_encoded_large.ppm
if [ $? -eq 0 ]; then
    echo "Large encoding test passed."
else
    echo "Large encoding test failed."
fi

# Test decoding of larger payload (text)
echo "Running decoding test with a larger text payload..."
./steganography decode test_encoded_large.ppm test_decoded_large.txt
if [ $? -eq 0 ]; then
    echo "Large decoding test passed."
else
    echo "Large decoding test failed."
fi

# Check if the decoded message is correct (large)
echo "Verifying decoded large text payload..."
if cmp -s large_payload.txt test_decoded_large.txt; then
    echo "Large payload match: Decoding successful!"
else
    echo "Decoded large message does not match payload!"
fi

# Test with binary payload
echo "Running encoding test with a binary payload..."
echo -n -e '\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A' > test_payload_bin.bin
./steganography encode test_input.ppm test_payload_bin.bin test_encoded_bin.ppm
if [ $? -eq 0 ]; then
    echo "Binary encoding test passed."
else
    echo "Binary encoding test failed."
fi

# Test decoding of binary payload
echo "Running decoding test with a binary payload..."
./steganography decode test_encoded_bin.ppm test_decoded_bin.bin
if [ $? -eq 0 ]; then
    echo "Binary decoding test passed."
else
    echo "Binary decoding test failed."
fi

# Check if the binary payloads match
echo "Verifying decoded binary payload..."
if cmp -s test_payload_bin.bin test_decoded_bin.bin; then
    echo "Binary payload match: Decoding successful!"
else
    echo "Decoded binary payload does not match the original!"
fi

# Test with too large of a payload
echo "Running test with a payload that exceeds the PPM capacity..."
dd if=/dev/urandom of=too_large_payload.bin bs=1024 count=1 2>/dev/null
./steganography encode test_input.ppm too_large_payload.bin test_encoded_overflow.ppm
if [ $? -eq 0 ]; then
    echo "Overflow test passed, this is an error case, it should fail."
else
    echo "Overflow test failed as expected (error handling works)."
fi

# Test for invalid file type during encoding
echo "Running encoding test with an invalid PPM format..."
echo "P4" > invalid_ppm.ppm
echo "3 2" >> invalid_ppm.ppm
echo "255" >> invalid_ppm.ppm
echo "255 0 0" >> invalid_ppm.ppm
echo "0 255 0" >> invalid_ppm.ppm
echo "0 0 255" >> invalid_ppm.ppm
./steganography encode invalid_ppm.ppm test_payload.txt test_encoded_invalid.ppm
if [ $? -ne 0 ]; then
    echo "Invalid PPM format correctly caught by encoding."
else
    echo "Invalid PPM format test failed."
fi

# Test for the same filename for input, payload, and output (encode)
echo "Running test where input, payload, and output filenames are the same..."
./steganography encode test_input.ppm test_payload.txt test_input.ppm
if [ $? -ne 0 ]; then
    echo "Correctly detected same filenames for encoding."
else
    echo "Error: Same filenames not detected during encoding."
fi

# Test for the same filename for input and output (decode)
echo "Running test where input and output filenames are the same (decode)..."
./steganography decode test_encoded.ppm test_encoded.ppm
if [ $? -ne 0 ]; then
    echo "Correctly detected same filenames for decoding."
else
    echo "Error: Same filenames not detected during decoding."
fi

# Test with a different image size (larger image)
echo "Running encoding with a larger PPM image..."
echo "P3
5 5
255
255 0 0 0 255 0 0 0 255 255 255 0 0 0 255 255 255 0 255 0 255 255 255 255 0 255 255
" > large_input.ppm
./steganography encode large_input.ppm test_payload.txt test_encoded_large_input.ppm
if [ $? -eq 0 ]; then
    echo "Large image encoding test passed."
else
    echo "Large image encoding test failed."
fi

# Test with non-printable characters in the payload
echo "Running test with non-printable characters in the payload..."
echo -n -e '\x00\x01\x02\x03\x04' > non_printable_payload.bin
./steganography encode test_input.ppm non_printable_payload.bin test_encoded_non_printable.ppm
if [ $? -eq 0 ]; then
    echo "Non-printable encoding test passed."
else
    echo "Non-printable encoding test failed."
fi

# Test for decoding non-printable payload
echo "Running decoding test with non-printable payload..."
./steganography decode test_encoded_non_printable.ppm test_decoded_non_printable.bin
if [ $? -eq 0 ]; then
    echo "Non-printable decoding test passed."
else
    echo "Non-printable decoding test failed."
fi

# Clean up
rm test_input.ppm test_payload.txt test_encoded.ppm test_decoded.txt large_payload.txt test_encoded_large.ppm test_decoded_large.txt test_payload_bin.bin test_encoded_bin.ppm test_decoded_bin.bin test_encoded_large_input.ppm invalid_ppm.ppm test_encoded_invalid.ppm test_encoded_overflow.ppm test_encoded_non_printable.ppm test_decoded_non_printable.bin

echo "All tests completed."

# Set compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -pedantic -g
LDFLAGS =

# Set project name
TARGET = steganography

# List of source files
SRC = src/main.c src/steganography.c src/ppm.c src/utils.c

# List of object files (based on source files)
OBJ = $(SRC:.c=.o)

# Define the directory structure
BUILD_DIR = build
SRC_DIR = src
BIN_DIR = bin

# Default target
all: $(BIN_DIR)/$(TARGET)

# Link the target
$(BIN_DIR)/$(TARGET): $(OBJ)
	@mkdir -p $(BIN_DIR)
	$(CC) $(OBJ) -o $(BIN_DIR)/$(TARGET) $(LDFLAGS)

# Compile the source files
$(SRC_DIR)/*.c.o:
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $(BUILD_DIR)/$(@F)

# Clean the project
clean:
	rm -rf $(BIN_DIR) $(BUILD_DIR)

# Run the program
run: $(BIN_DIR)/$(TARGET)
	./$(BIN_DIR)/$(TARGET)

# Test the program
test: $(BIN_DIR)/$(TARGET)
	./test.sh

# Phony targets (not real files)
.PHONY: all clean run test

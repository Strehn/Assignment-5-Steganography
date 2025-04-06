CC = gcc
CFLAGS = -Wall -Wextra -g
LDFLAGS = 
EXEC = bin/game_of_life

# Source files
SRC = src/main.c src/picture.c src/rules.c src/arrays.c
OBJ = $(SRC:.c=.o)

# Directories
OBJ_DIR = obj
BIN_DIR = bin
SRC_DIR = src
TEST_SCRIPT = test.sh

# Targets

# Default target to build everything
all: $(EXEC)

# Compile the game_of_life executable
$(EXEC): $(OBJ)
	@mkdir -p $(BIN_DIR)
	$(CC) $(OBJ) -o $(EXEC) $(LDFLAGS)

# Compile source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up object files and the executable
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)
	rm -f $(EXEC)

# Run the tests using the test.sh script
test: $(EXEC)
	@echo "Running tests..."
	./$(TEST_SCRIPT)

# Ensure the program is built before running tests
build: $(EXEC)

# Phony targets (these don't represent real files)
.PHONY: all clean test build

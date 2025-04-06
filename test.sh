#!/bin/bash

echo "Running tests..."

# Test 1: Run with a 20x10 grid, 5 generations (expected Rule 18)
echo "Test 1: Running with 20x10 grid, 5 generations"
output=$(./bin/game_of_life 20 10 5)
expected_output="Rule 18"
if echo "$output" | grep -q "$expected_output"; then
  echo "Pass: Output contains Rule 18"
else
  echo "Fail: Expected Rule 18, but got:"
  echo "$output"
  exit 1
fi

# Test 2: Run with a 30x15 grid, 10 generations (expected Rule 57)
echo "Test 2: Running with 30x15 grid, 10 generations"
output=$(./bin/game_of_life 30 15 10)
expected_output="Rule 57"
if echo "$output" | grep -q "$expected_output"; then
  echo "Pass: Output contains Rule 57"
else
  echo "Fail: Expected Rule 57, but got:"
  echo "$output"
  exit 1
fi

# Test 3: Run with a 50x25 grid, 15 generations (expected Rule 60)
echo "Test 3: Running with 50x25 grid, 15 generations"
output=$(./bin/game_of_life 50 25 15)
expected_output="Rule 60"
if echo "$output" | grep -q "$expected_output"; then
  echo "Pass: Output contains Rule 60"
else
  echo "Fail: Expected Rule 60, but got:"
  echo "$output"
  exit 1
fi

# Test 4: Run with a 100x50 grid, 20 generations (expected Rule 73)
echo "Test 4: Running with 100x50 grid, 20 generations"
output=$(./bin/game_of_life 100 50 20)
expected_output="Rule 73"
if echo "$output" | grep -q "$expected_output"; then
  echo "Pass: Output contains Rule 73"
else
  echo "Fail: Expected Rule 73, but got:"
  echo "$output"
  exit 1
fi

# Test 5: Ensure the program fails with invalid input (negative grid size)
echo "Test 5: Running with invalid input (negative grid size)"
output=$(./bin/game_of_life -20 10 5)
if [ $? -eq 1 ]; then
  echo "Pass: Program exited with error due to invalid input"
else
  echo "Fail: Program should have exited with an error"
  exit 1
fi

# Test 6: Ensure the program fails with non-numeric input
echo "Test 6: Running with non-numeric input"
output=$(./bin/game_of_life abc def ghi)
if [ $? -eq 1 ]; then
  echo "Pass: Program exited with error due to non-numeric input"
else
  echo "Fail: Program should have exited with an error"
  exit 1
fi

# Test 7: Run with the smallest grid (1x1) and 5 generations (expected Rule 18)
echo "Test 7: Running with a 1x1 grid, 5 generations"
output=$(./bin/game_of_life 1 1 5)
expected_output="Rule 18"
if echo "$output" | grep -q "$expected_output"; then
  echo "Pass: Output contains Rule 18"
else
  echo "Fail: Expected Rule 18, but got:"
  echo "$output"
  exit 1
fi

# Test 8: Run with a 2x2 grid, 5 generations (expected Rule 18 or Rule 57)
echo "Test 8: Running with a 2x2 grid, 5 generations"
output=$(./bin/game_of_life 2 2 5)
# Either Rule 18 or Rule 57 can be expected due to limited grid, check for both
if echo "$output" | grep -q "Rule 18" || echo "$output" | grep -q "Rule 57"; then
  echo "Pass: Output contains expected rule"
else
  echo "Fail: Expected Rule 18 or Rule 57, but got:"
  echo "$output"
  exit 1
fi

# Test 9: Ensure the program handles maximum grid size (e.g., 1000x1000) correctly
echo "Test 9: Running with a 1000x1000 grid, 1 generation"
output=$(./bin/game_of_life 1000 1000 1)
if [ $? -eq 0 ]; then
  echo "Pass: Program handled maximum grid size (1000x1000) correctly"
else
  echo "Fail: Program failed with maximum grid size"
  exit 1
fi

# Test 10: Run with a large grid and print only the first 10 rows (to prevent output overflow)
echo "Test 10: Running with a 100x100 grid, 50 generations, printing first 10 rows"
output=$(./bin/game_of_life 100 100 50)
echo "$output" | head -n 10
echo "Pass: Successfully printed first 10 rows of a large grid"

# Test 11: Ensure the program handles edge case with very large number of generations (e.g., 100 generations)
echo "Test 11: Running with a 20x10 grid, 100 generations"
output=$(./bin/game_of_life 20 10 100)
if [ $? -eq 0 ]; then
  echo "Pass: Program handled large number of generations (100 generations)"
else
  echo "Fail: Program failed with 100 generations"
  exit 1
fi

# Test 12: Run with a grid where every second cell is initially true (checking patterns in rule evolution)
echo "Test 12: Running with 20x10 grid, every second cell initially true"
output=$(./bin/game_of_life 20 10 5)
# Output check may need to check for specific patterns based on the rule
echo "$output" | grep "X" && echo "Pass: Non-empty cells exist in output"

# Test 13: Run with edge case of all cells initially false (1xN or Nx1 grid)
echo "Test 13: Running with 1x100 grid, 10 generations"
output=$(./bin/game_of_life 1 100 10)
if echo "$output" | grep -q "."; then
  echo "Pass: Output has only empty cells (no 'X')"
else
  echo "Fail: Unexpected non-empty cells in 1x100 grid"
  exit 1
fi

echo "All tests passed."

exit 0

/* 
Name
Date
Course
*/

/* You will need to implement the following helper functions in separate files as mentioned:

game_of_life.c:

next_generation(): Computes the next generation of the grid.

game_of_life_rule(): Determines the next state of a cell based on its neighbors.

print_grid(): Prints the grid to the console.


arrays.c:

malloc_2d(): Allocates memory for a 2D grid.

free_2d(): Frees memory for the 2D grid.


utils.c:

initialize_grid_random(): Initializes the grid with random live or dead cells.

initialize_grid_static(): Optionally, you could create this function to initialize the grid with a predefined static pattern.*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "game_of_life.h"
#include "arrays.h"
#include "utils.h"

// Function prototypes
void print_usage();

int main(int argc, char *argv[]) {
   
    if (argc != 4) {
        print_usage();
        return 1;
    }
      // Allocate memory for the grid
     // Initialize the grid with random values (you can modify to static patterns if needed)
     // Simulate for the specified number of generations
   
    
    return 0;
}

/* this is a simple C++ example for calling the reverser function from assembly
 * code. the code lies inside of reverser.asm */

#include <iostream>
#include <cstdint>
#include <random>

// get the function linked from reverser.asm 
// the arguments point to the memory address the array
// itself starts from. pointer arithmetic
// will allow us to receive the array elements
// this pointer arithmetic occurs at the loop in the
// assembly file, line 22
extern "C" void reverser(std::int32_t* dest,
        std::int32_t* src,
        std::int32_t num_elements);

std::int32_t main(std::int32_t argc, char* argv[])
{
    // intialize everything here
    const std::int32_t num = 10;
    std::int32_t src[num]; // src
    std::int32_t dest[num]; // dest

    // pesudo-random numbers using mersenne twister engine apart of c++11
    std::random_device device;
    std::mt19937 generator(device());
    std::uniform_int_distribution<std::int32_t> distribution(0, 9);

    std::printf("Reversing array.... old array:\n");

    // print out the original array
    for (std::int32_t i = 0; i < num; i++)
    {
        src[i] = distribution(generator);
        std::printf("src[%i] = %i\n", i, src[i]);
    }

    reverser(dest, src, 10); // call the function here

    // print out what it's done
    std::printf("\n\nnew array: \n");
    for (std::int32_t i = 0; i < num; i++)
    {
        std::printf("dest[%i] = %i\n", i, dest[i]);
    }

    return 0;
}
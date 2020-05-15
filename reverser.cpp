#include <cstdint>

extern "C" void reverser(std::int32_t* dest,
                         std::int32_t* src,
                         std::int32_t num_elements)
{
    for ( uint32_t j=0; j<num_elements; ++j ) {
        dest[num_elements-j-1] = src[j];
    }
}

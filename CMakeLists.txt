

set( CMAKE_ASM_NASM_COMPILER "yasm" CACHE STRING "NASM Assembler executable" )

project( asm-reverser )
cmake_minimum_required( VERSION 3.0 )

set( SOURCES main.cpp )
if ( UNIX )
  enable_language( ASM )
  list( APPEND SOURCES reverser.s )
elseif( WIN32 )
  enable_language( ASM )
  enable_language( ASM_NASM )
  list( APPEND SOURCES reverser.asm )
else()
  list( APPEND SOURCES reverser.cpp )
endif()

add_executable( asm-reverser ${SOURCES} )
install( TARGETS asm-reverser RUNTIME DESTINATION bin )

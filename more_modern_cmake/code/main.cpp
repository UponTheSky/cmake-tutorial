#include <iostream>

#include "simple_lib.h"

// #ifndef MYLIB_PUBLIC
// #error "Must have MYLIB_PUBLIC defined"
// #endif

// #ifdef MYLIB_PRIVATE
// #error "Must not have MYLIB_PRIVATE defined"
// #endif

int main() {
  std::cout << "Hello, CMake!" << std::endl;

  return 0;
}

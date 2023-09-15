cmake_minimum_required(VERSION 3.27)

project(MyProject)

add_library(simple_lib simple_lib.cpp simple_lib.h)

target_include_directories(simple_lib PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")

target_compile_definitions(simple_lib PUBLIC MY_LIB_PUBLIC)
target_compile_definitions(simple_lib PRIVATE MY_LIB_PRIVATE)

target_compile_features(simple_lib PUBLIC cxx_std_11)

add_executable(app main.cpp)

target_link_libraries(app PRIVATE simple_lib)

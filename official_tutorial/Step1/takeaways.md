# Takeaways
1. what is CMake?
- CMake is a tool for building a C/C++ project
- it first configures the project, and generates a native build system
- with extra setup variables, CMake can flexibly compile a given project

2. Basic workflow
  1. config the project and generate a native build system
    - `cmake <directory>` => the `<directory>` must have `CMakeLists.txt`
    - `CMakeLists.txt` is a config text file where you set up the build configs for any systems supported by CMake
    - Rather than the basic project setup, you don't have to re-generate the build system - just compile

  2. build the project
    - `cmake --build <directory>`

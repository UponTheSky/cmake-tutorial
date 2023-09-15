# More Modern CMake
- link: https://hsf-training.github.io/hsf-training-cmake-webpage/aio/index.html
- references
  - https://cliutils.gitlab.io/modern-cmake/
  - https://www.siliceum.com/en/blog/post/cmake_01_cmake-basics/
  - https://www.siliceum.com/en/blog/post/cmake_02_customization-points/
  - https://cmake.org/cmake/help/latest/manual/cmake.1.html

## Why this tutorial?
- Originally, I thought of going through the reference book first. However, I found it more suitable as a reference rather than a tutorial.

- After reading through this, we will go back to the official tutorial and finish it.

## What is CMake anyways?
- Read: https://cmake.org/cmake/help/latest/manual/cmake.1.html#introduction-to-cmake-buildsystems

## Running CMake
0. Write a `CMakeLists.txt` file in the source dir(`<src>`)

1. Generate a Project build system
  - `cmake -S <src> -B <build>`
  - `<build>` is by convention `build`
  - automatically generate `<build>` dir if there weren't such a dir
  - https://cmake.org/cmake/help/latest/manual/cmake.1.html#generate-a-project-buildsystem

2. After generating a build system, you now build the project
- you don't have to invoke the native build tool
- `cmake --build <build>`
- you may specify the target rather than the default one by `-t(--target)`
- also, you may run a parallel building jobs using `-j(--parallel)`

**remark**: what the heck is *install*?
- read: https://cmake.org/cmake/help/book/mastering-cmake/chapter/Install.html
- `cmake <src> --install`

3. Run the built binary file

## How to write CMakeLists.txt?
1. Basics: specify
- CMake version
- project name
- add a **target**: either an executable or a library

2. Working with Targets
- executable, library(`STATIC`, `SHARED`, `MODULE`)
- several target -> linking
  - `target_link_libraries`
  - relationship: `PUBLIC`, `PRIVATE`, `INTERFACE`

**Remark**: `PUBLIC` vs `PRIVATE` vs `INTERFACE`
- every target has two kinds of properties
  - private: control what happens when you build the target itself(not transitive)
  - interface: tell targets linked to this target what to do when building them, but not applied to this very target
  - public?: fills both properties at the same time

3. Variables explained
- cached variables using `set()`
- environment variables: `$ENV{name}`
- CMake built-in variable names: target properties -> `CMAKE_TARGET_PROP_NAME`
- globa variable: matching - `file(GLOB OUTPUT_VAR, *.cpp)`

4. Project Structure
- ...

5. Common Problems and Solutions, Debugging
- ...

7. Finding Packages
- ...

8. ROOT, Functions in CMake
- ...



# Takeaways
- all about scopes(defining dependencies btw libraries)
  - a good reading: https://leimao.github.io/blog/CMake-Public-Private-Interface/
  - `foo PUBLIC bar`: foo uses b, and others that use foo depend on bar
  - `foo PRIVATE bar`: foo uses b, and that's all(not transitive)
  - `foo INTERFACE bar`: foo don't use b, but others that use foo depend on bar
- interface library

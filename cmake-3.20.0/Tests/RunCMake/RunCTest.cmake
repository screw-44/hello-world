include(RunCMake)

function(run_ctest CASE_NAME)
  configure_file(${RunCMake_SOURCE_DIR}/test.cmake.in
                 ${RunCMake_BINARY_DIR}/${CASE_NAME}/test.cmake @ONLY)
  if(EXISTS "${RunCMake_SOURCE_DIR}/CTestConfig.cmake.in")
    configure_file(${RunCMake_SOURCE_DIR}/CTestConfig.cmake.in
                   ${RunCMake_BINARY_DIR}/${CASE_NAME}/CTestConfig.cmake @ONLY)
  else()
    file(REMOVE ${RunCMake_BINARY_DIR}/${CASE_NAME}/CTestConfig.cmake)
  endif()
  configure_file(${RunCMake_SOURCE_DIR}/CMakeLists.txt.in
                 ${RunCMake_BINARY_DIR}/${CASE_NAME}/CMakeLists.txt @ONLY)
  run_cmake_command(${CASE_NAME} ${CMAKE_CTEST_COMMAND}
    -C Debug
    -S ${RunCMake_BINARY_DIR}/${CASE_NAME}/test.cmake
    -V
    --output-log ${RunCMake_BINARY_DIR}/${CASE_NAME}-build/testOutput.log
    --no-compress-output
    ${ARGN}
    )
endfunction()

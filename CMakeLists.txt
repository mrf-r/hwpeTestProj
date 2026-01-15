cmake_minimum_required(VERSION 3.23)
project(hwpeTestProj)

add_subdirectory(m-osc)
add_subdirectory(libs)

# to read
# https://cmake.org/cmake/help/latest/genindex.html
# https://github.com/FreeRTOS/FreeRTOS-Kernel/blob/main/CMakeLists.txt
# https://github.com/SynthstromAudible/DelugeFirmware/blob/community/src/OSLikeStuff/CMakeLists.txt
# https://github.com/nonlinear-labs-dev/nl-firmware/blob/main/projects/epc/audio-engine/CMakeLists.txt
# https://github.com/raspberrypi/pico-sdk - some overcomplicated stuff that doesn't work

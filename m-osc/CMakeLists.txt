
add_executable(App)

target_sources(App
    PRIVATE
        synth.c
        userpanel.c
)

target_link_libraries(App
    PUBLIC
        hwPanelEmulator
        mbwmidi
        minimalgraphics
)

target_compile_options(App
    PRIVATE
        -Wall -Wextra -Wpedantic
        -std=c11 -Wdouble-promotion
)

add_library(hwPanelEmulator_config INTERFACE)
target_sources(hwPanelEmulator_config
    INTERFACE
    FILE_SET HEADERS
    BASE_DIRS
        ${CMAKE_CURRENT_LIST_DIR}
    FILES
        ${CMAKE_CURRENT_LIST_DIR}/panel_conf.h
)


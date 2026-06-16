set(EXTENSIONS_DIR ${CMAKE_CURRENT_LIST_DIR}/superbuild-extensions)
include(${CMAKE_CURRENT_LIST_DIR}/plugins/mc_robotiq.cmake)
set(WITH_UR5E ON CACHE BOOL "" FORCE)
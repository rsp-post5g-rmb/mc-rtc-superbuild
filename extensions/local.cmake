set(EXTENSIONS_DIR ${CMAKE_CURRENT_LIST_DIR}/superbuild-extensions)

set(WITH_UR5E    ON CACHE BOOL "" FORCE)  # -> mc_ur5e + mc_ur5e_description
set(WITH_TRIORB  ON CACHE BOOL "" FORCE)  # -> mc_triorb_module + mc_triorb_description
set(WITH_MC_RTDE ON CACHE BOOL "" FORCE)  # -> mc_rtde + ur_rtde + ur_modern_driver (hardware)

include(${CMAKE_CURRENT_LIST_DIR}/tools/mc_robot_tools.cmake)             # gripper module
include(${CMAKE_CURRENT_LIST_DIR}/plugins/mc_robotiq.cmake)              # gripper plugin
include(${CMAKE_CURRENT_LIST_DIR}/plugins/mc_triorb.cmake)              # base plugin
include(${CMAKE_CURRENT_LIST_DIR}/controllers/callm_wbc_controller.cmake) # the controller
include(${CMAKE_CURRENT_LIST_DIR}/observers/mc_visual_odometry_observer.cmake) # VO observer
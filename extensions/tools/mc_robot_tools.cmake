# robotiq_gripper (part of mc_robot_tools) needs the upstream robotiq_description
# ROS package for its URDF/meshes, see mc_robot_tools' own README/CI.
AddCatkinProject(
  robotiq_description
  GITHUB PickNikRobotics/ros2_robotiq_gripper
  GIT_TAG origin/main
  WORKSPACE data_ws
)

if(WITH_ROS_SUPPORT)
  # ros2_robotiq_gripper is a multi-package repo; only robotiq_description's
  # URDF/meshes are needed here. The sibling packages pull in ros2_control /
  # hardware driver dependencies (controller_interface, ur_client_library, ...)
  # that this superbuild does not provide, so make colcon skip them.
  get_property(DATA_WS_DIR GLOBAL PROPERTY CATKIN_WORKSPACE_data_ws_DIR)
  ExternalProject_Add_Step(
    robotiq_description ignore-unused-packages
    COMMAND
      ${CMAKE_COMMAND} -E touch
      "${DATA_WS_DIR}/src/robotiq_description/robotiq_controllers/COLCON_IGNORE"
      "${DATA_WS_DIR}/src/robotiq_description/robotiq_driver/COLCON_IGNORE"
      "${DATA_WS_DIR}/src/robotiq_description/robotiq_hardware_tests/COLCON_IGNORE"
    DEPENDEES download
    DEPENDERS configure
  )
endif()

AddProject(mc_robot_tools
  GITHUB_PRIVATE rsp-post5g-rmb/mc_robot_tools
  GIT_TAG origin/main
  CMAKE_ARGS -DWITH_ROBOTIQ_GRIPPER=ON
  DEPENDS mc_rtc robotiq_description
)
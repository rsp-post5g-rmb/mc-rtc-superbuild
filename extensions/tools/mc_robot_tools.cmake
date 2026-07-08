AddProject(mc_robot_tools
  GITHUB_PRIVATE rsp-post5g-rmb/mc_robot_tools
  GIT_TAG origin/main
  CMAKE_ARGS -DWITH_ROBOTIQ_GRIPPER=ON
  DEPENDS mc_rtc
)
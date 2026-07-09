option(WITH_MC_RTDE "Build mc_rtde control interface for UR5E and UR10 support (>=CB3)"
       OFF
)
option(WITH_UR3E "Build UR3E support" OFF)
option(WITH_UR5E "Build UR5E support" OFF)
option(WITH_UR10 "Build UR10 support" OFF)

if(WITH_MC_RTDE)
  AptInstall(libcap2-bin) # For setcap

  # For CB>=3 support. Built from source instead of the ppa:sdurobotics/ur-rtde PPA,
  # which requires querying Launchpad's API (an endpoint known to time out
  # intermittently) even when the actual package mirror is reachable.
  set(MC_RTDE_EXTRA_DEPENDS)
  find_package(ur_rtde QUIET)
  if(NOT ${ur_rtde_FOUND})
    AddProject(
      ur_rtde
      GIT_REPOSITORY https://gitlab.com/sdurobotics/ur_rtde.git
      GIT_TAG origin/master
      # PYTHON_BINDINGS defaults to ON and installs into the system's
      # dist-packages regardless of CMAKE_INSTALL_PREFIX, which requires root
      # and isn't what we want in the superbuild's install prefix.
      CMAKE_ARGS -DPYTHON_BINDINGS:BOOL=OFF
    )
    list(APPEND MC_RTDE_EXTRA_DEPENDS ur_rtde)
  endif()

  # For CB<=2 support
  AddProject(
    ur_modern_driver
    GITHUB jrl-umi3218/ur_modern_driver
    GIT_TAG origin/main
  )

  AddProject(
    mc_rtde
    GITHUB isri-aist/mc_rtde
    GIT_TAG origin/main
    DEPENDS mc_rtc ur_modern_driver ${MC_RTDE_EXTRA_DEPENDS}
  )
endif()

if(WITH_UR10
   OR WITH_UR5E
   OR WITH_UR3E
)
  if(ROS_IS_ROS2)
    AddCatkinProject(
      ur_description
      GITHUB UniversalRobots/Universal_Robots_ROS2_Description
      GIT_TAG origin/humble
      WORKSPACE data_ws
    )
  else() # ROS1
    AddCatkinProject(
      ur_description
      GITHUB ros-industrial/universal_robot
      GIT_TAG noetic-devel/ur_description
      WORKSPACE data_ws
    )
  endif()
endif()

if(WITH_UR10)
  AddCatkinProject(
    mc_ur10_description
    GITHUB isri-aist/mc_ur10_description
    GIT_TAG origin/main
    DEPENDS ur_description
    WORKSPACE data_ws
  )
  AddProject(
    mc_ur10
    GITHUB isri-aist/mc_ur10
    GIT_TAG origin/main
    DEPENDS mc_ur10_description mc_rtc
  )
endif()

if(WITH_UR5E)
  AddCatkinProject(
    mc_ur5e_description
    GITHUB isri-aist/mc_ur5e_description
    GIT_TAG origin/main
    DEPENDS ur_description
    WORKSPACE data_ws
  )
  AddProject(
    mc_ur5e
    GITHUB isri-aist/mc_ur5e
    GIT_TAG origin/main
    DEPENDS mc_ur5e_description mc_rtc
  )
endif()

if(WITH_UR3E)
  AddCatkinProject(
    mc_ur3e_description
    GITHUB isri-aist/mc_ur3e_description
    GIT_TAG origin/main
    DEPENDS ur_description
    WORKSPACE data_ws
  )
  AddProject(
    mc_ur3e
    GITHUB isri-aist/mc_ur3e
    GIT_TAG origin/master
    DEPENDS mc_ur3e_description mc_rtc
  )
endif()

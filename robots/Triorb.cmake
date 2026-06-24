option(WITH_TRIORB "Build with Triorb base support" OFF)

if(NOT WITH_TRIORB)
  return()
endif()

AddCatkinProject(
  mc_triorb_description
  GITHUB rsp-post5g-rmb/mc_triorb_description
  GIT_TAG origin/main
  WORKSPACE data_ws
)

AddProject(
  mc_triorb_module
  GITHUB rsp-post5g-rmb/mc_triorb_module
  GIT_TAG origin/main
  DEPENDS mc_triorb_description mc_rtc
)

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO  L0ric0/ads1115
	REF efa258f1cffa0f52ab5d8670596fb4e9598e2e29
	SHA512 20a42abd73318a5cd2636ac06e1e34ca2bc3db35857759a386489ac295afae2a263861ccb3d7f304a4ff4bd095339976f9d921faec1607c5cefcfc600870d7eb
	HEAD_REF master
)


vcpkg_cmake_configure(
	SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME ${PORT} CONFIG_PATH lib/cmake/${PORT}/)

if(VCPKG_TARGET_IS_WINDOWS)
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        vcpkg_replace_string(${CURRENT_PACKAGES_DIR}/share/ads1115/ads1115-targets-debug.cmake
            "lib/ads1115.dll"
            "bin/ads1115.dll"
        )
    endif()
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        vcpkg_replace_string(${CURRENT_PACKAGES_DIR}/share/i2c-device/i2c-device-targets-release.cmake
            "lib/ads1115.dll"
            "bin/ads1115.dll"
        )
    endif()
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

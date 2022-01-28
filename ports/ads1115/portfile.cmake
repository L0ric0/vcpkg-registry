vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO  L0ric0/ads1115
	REF 743732a9ac3e65a3f37784c06d0f504ba7e60d7f
	SHA512 e084d8d39c1f63e51d60c9802fb8e62d2efcf1ff440b46e8a3c600e7a2e52813202294e74831c97bdd45d0636f4a835b61c372033c21072ee50f00da0e3fd597
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

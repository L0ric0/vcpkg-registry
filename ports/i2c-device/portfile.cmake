vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO  L0ric0/i2c_device
	REF d4d363a33564b8a5228a2574391e60cc18cc8277
	SHA512 5CB862817B90D1B341C1A6848C703718FCBBDA7C05CE76DCC0ECFEFACB6B473FBCCB94B9CAF4DF4C198AB85BCB164B0500B29C6DA55F624E7525D81B30AA8609
	HEAD_REF master
)


vcpkg_cmake_configure(
	SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME ${PORT} CONFIG_PATH lib/cmake/${PORT}/)

if(VCPKG_TARGET_IS_WINDOWS)
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        vcpkg_replace_string(${CURRENT_PACKAGES_DIR}/share/i2c-device/i2c-device-targets-debug.cmake
            "lib/i2c-device.dll"
            "bin/i2c-device.dll"
        )
    endif()
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        vcpkg_replace_string(${CURRENT_PACKAGES_DIR}/share/i2c-device/i2c-device-targets-release.cmake
            "lib/i2c-device.dll"
            "bin/i2c-device.dll"
        )
    endif()
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

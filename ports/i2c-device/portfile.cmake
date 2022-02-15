vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO  L0ric0/i2c_device
	REF 45834e48a4f93e81ef3449e507439f1f17f8fcc9
	SHA512 20e0824877496e8830d25bc60df12636281945f1dc43cdc56d64925cfa1686c2c8a3f44a74bae1adad3a5f69dfde1328964b5056cc9b76f4e7adc3b6ca5c1f76
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

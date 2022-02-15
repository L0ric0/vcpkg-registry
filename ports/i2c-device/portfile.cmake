vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO  L0ric0/i2c_device
	REF 24ab246d84953c9e3b22527c2ad1fce29045cb61
	SHA512 270d357faaa1dd7c547f13f91ee3aa89ca90f42cdbda24344512fd63bcaff3f4ef9e549a6bdb10df79d36af5ad5b019d1a67f09105b0b9d90ef45518506e3205
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

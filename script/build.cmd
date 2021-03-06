@echo off
set lang=English
set buildType=Release
set buildDir=build

cd ..

if "%1" equ "help" (
    echo Usage:
    echo   build [build_type] [language]
    echo                   build [build_type] version in [language], default Release in
    echo                   English
    echo   build help      display this help and exit
    exit 0
) else ( if "%1" equ "Chinese" (
    set lang=Chinese
    cmd /c script\changeEncoding utf-8 gbk
) else ( if "%1" equ "English" (
    set lang=English
) else ( if "%1" equ "Debug" (
    set buildType=Debug
    if "%2" equ "Chinese" (
        set lang=Chinese
        cmd /c script\changeEncoding utf-8 gbk
    ) else ( if "%2" neq "English" (
        echo build: '%2' -- language not supported
        echo Usage:
        echo   build [build_type] [language]
        echo                   build [build_type] version in [language], default Release in English
        echo   build help      display this help and exit
        exit 1
    ))
) else ( if "%1" neq "" ( if "%1" neq "Release" (
    echo build: '%1': no such instruction
    exit 1
)))))))

mkdir build
cmake -D STARS_LANGUAGE_SETIING=%lang% -D CMAKE_BUILD_TYPE=%buildType% -S . -B %buildDir% && ^
cmake --build %buildDir% --config Release --target stars

if "%lang%" equ "Chinese" (
    cmd /c script\changeEncoding gbk utf-8
)

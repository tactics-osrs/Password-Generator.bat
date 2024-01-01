@echo off
:top
TITLE Random Password Generator
setlocal EnableDelayedExpansion

:: Define a string of characters to choose from
set "chars=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

:: Ask the user for the length of the password
set /p length="Enter the length of the password: "

:: Check if the length is empty or not a number
echo %length%|findstr /r /x "[0-9]*" >nul || (
    echo Please input a valid number for the password length.
    goto top
)

:: Check if the length exceeds the maximum limit
if %length% gtr 5000 (
    echo The password length must not exceed 5000 characters.
    goto top
)

:: Initialize the password variable
set "password="

:: Generate the password
for /L %%i in (1, 1, %length%) do (
    set /a "rand=(!random! %% 62)"
    for /L %%j in (!rand!, 1, !rand!) do set "char=!chars:~%%j,1!"
    set "password=!password!!char!"
)

:: Output the password
echo Your password is: !password!

:: Copy the password to the clipboard
echo !password! | clip

:: Inform the user that the password has been copied
echo The password '!password!' has been copied to your clipboard.

echo.
echo Press any key to generate another password...
pause >nul
endlocal
goto top

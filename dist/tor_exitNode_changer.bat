@echo off & SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:: ====================================================================================
:: Name          : Tor Browser {Exit Nodes} Changer
:: Description   : Batch script to change Tor's {Exit Nodes} Country Codes
:: Version       : 1.2
:: Enviroment    : Windows CMD Shell
:: Author        : gmo
:: Proyect       : https://github.com/gmolop/Tor-ExitNode-changer
:: Tested on     : Windows 10 pro / cmd.exe 10.0.10586.0 / Tor Browser 5.5.5 (based on Mozilla Firefox 38.8.0)
:: ====================================================================================

title=[gmo]( ExitNode Changer )

echo.
echo  _____________________________________
echo  Starting TOR with ExitNode Changer...
echo.

call :SetConfig
call :clean_temp_files

:: ====================================================================================
:: Set config vars and start
:SetConfig
    echo  Setting up environment variables.....

    :: get current script path
    set curr_path="%CD%"

    :: -----------------------------------------------
    :: ----------  START CUSTOM CONFIG  --------------
    :: -----------------------------------------------
    :: changes /maybe/ needed starting here
    :: you only need to change this, if the .bat
    :: is not in the same folder as the torrc file

    :: set TOR executable path, relative to script location (trailing slash)
    set tor_path="%curr_path%\..\..\..\"

    :: set current TOR file name
    set tor_current_name="firefox.exe"

    :: set new TOR file name (give a unique name)
    set tor_new_name="tor.exe"

    :: set "torrc" file path, relative to script location
    :: (trailing slash only if it's not empty)
    set torrc_path=""

    :: set "torrc" file name
    set torrc_name="torrc"

    :: no more changes below this line
    :: -----------------------------------------------
    :: -----------  END CUSTOM CONFIG  ---------------
    :: -----------------------------------------------

    :: set torrc_file
    set torrc_file="%torrc_path%%torrc_name%"

    :: set temporary file to store and restore
    set temp_torrc="torrc.temp"

    echo                                  done/

    call :start_
EXIT /b

:: ====================================================================================
:start_
    call :CreateNewExe
    call :FindCurrent
    call :CreateSupport
    call :doTheJob %torrc_name%
EXIT /b

:: ====================================================================================
:doTheJob <file>

    echo  Requesting new ExitNode value........
    for /f %%a in ('cscript //nologo _pen.vbs') do set "ISOcodeUser=%%a"
    if "%ISOcodeUser%" == "" call :clean_temp_files

    :: check, trim and upprcase
    call :trimSpaces ISOcode %ISOcodeUser%
    call :toUpper ISOcode

    echo                                  done/

    echo  Closing old instance of TOR..........
    taskkill /f /im %tor_new_name% >nul 2>&1
    echo                                  done/

    echo  Replacing with "%ISOcode%" in file %torrc_name%....

    if %currentExitNode% EQU 1 (
        :: if not exist in torrc, append it, at the end of the file
        >>%torrc_file% echo.
        >>%torrc_file% echo ExitNodes {%ISOcode%}
        >>%torrc_file% echo.
    ) else (
        :: exist.. do the replace
        for /f "tokens=*" %%a in ('dir "%torrc_file%" /s /b /a-d /on') do (
            <%%a cscript //nologo _mr.vbs "%ISOcode%" "%torrc_file%">%temp_torrc%
            if exist %temp_torrc% move /Y %temp_torrc% "%%~dpnxa">nul
        )
    )

    echo                                  done/

    echo  Starting new instance of TOR.........
    start "TOR" /D "%tor_path%" "%tor_new_name%"
    echo                                  done/
EXIT /b

:: ====================================================================================
:CreateNewExe
    echo  Creating a new instance of TOR.......
    :: create the new instance of TOR
    if not exist "%tor_path%%tor_new_name%" (
        copy "%tor_path%%tor_current_name%" "%tor_path%%tor_new_name%"
    )
    echo                                  done/
EXIT /b

:: ====================================================================================
:CreateSupport
    echo  Creating support files...............
    if %currentExitNode% EQU 1 (
        set currVal=""
    ) else (
        set currVal="%currentExitNode%"
    )

    :: create the file that will prompt the new ExitNode
    >_pen.vbs echo ISOcountryCode = InputBox _
    >>_pen.vbs echo ("Enter ISO3166 country code: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2","ExitNodes",%currVal%)
    >>_pen.vbs echo Wscript.Echo ISOcountryCode

    :: create file that will do the replace
    >_mr.vbs  echo with Wscript
    >>_mr.vbs echo Set args=.arguments
    >>_mr.vbs echo Set objRegEx = CreateObject("VBScript.RegExp")
    >>_mr.vbs echo objRegEx.Pattern = "ExitNodes\ \{(.*)\}"
    >>_mr.vbs echo .StdOut.Write _
    >>_mr.vbs echo objRegEx.Replace(.StdIn.ReadAll,"ExitNodes {" + args(0) + "}")
    >>_mr.vbs echo end with

    echo                                  done/
EXIT /b

:: ====================================================================================
:FindCurrent
    echo  Searching current ExitNode value.....
    set currentExitNode=1

    >_fc.vbs  echo Set objFSO = CreateObject("Scripting.FileSystemObject")
    >>_fc.vbs echo Set file = objFSO.OpenTextFile(%torrc_name% , ForReading)
    >>_fc.vbs echo Const ForReading = 1
    >>_fc.vbs echo Dim re
    >>_fc.vbs echo Set re = new regexp
    >>_fc.vbs echo re.Pattern = "ExitNodes\ \{(.*)\}"
    >>_fc.vbs echo re.IgnoreCase = True
    >>_fc.vbs echo re.Global = True
    >>_fc.vbs echo Dim line
    >>_fc.vbs echo Do Until file.AtEndOfStream
    >>_fc.vbs echo     line = file.ReadLine
    >>_fc.vbs echo     For Each m In re.Execute(line)
    >>_fc.vbs echo        Wscript.Echo m.Submatches(0)
    >>_fc.vbs echo     Next
    >>_fc.vbs echo Loop

    for /f %%a in ('cscript //nologo _fc.vbs') do set "currentExitNode=%%a"

    echo                                  done/
EXIT /b

:: ====================================================================================
:: converts string to uppercase
:toUpper
    for %%L IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO SET %1=!%1:%%L=%%L!
EXIT /b

:: ====================================================================================
:: converts string to lowercase
:tolower
    for %%L IN (a b c d e f g h i j k l m n o p q r s t u v w x y z) DO SET %1=!%1:%%L=%%L!
EXIT /b

:: ====================================================================================
::trims spaces around string and assigns result to variable
:trimSpaces retval string
    for /f "tokens=1*" %%A in ("%*") do set "%%A=%%B"
EXIT /b

:: ====================================================================================
:clean_temp_files
    echo  Deleting support files...............

    if exist "%temp_torrc%" ( del %temp_torrc% )
    if exist "_fc.vbs"      ( del _fc.vbs      )
    if exist "_mr.vbs"      ( del _mr.vbs      )
    if exist "_pen.vbs"     ( del _pen.vbs     )

    echo                                  done/

    echo  _____________________________________
    echo  .......................... All done//
    TIMEOUT /T 5
    GOTO EOF
EXIT /b

:: ====================================================================================
:: and exit
:EOF
EXIT

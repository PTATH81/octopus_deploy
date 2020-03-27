@ECHO OFF
SETLOCAL
::==================================================
:: THIS SCRIPT SHOULD ONLY BE USED AS A LAST RESTORT
::==================================================
:: ADD VARIABLE(s) HERE.
::
SET BOX_TYPE="gusztavvargadr/windows-server"
::
::=====================================

ECHO ===========================================================================
ECHO RUNNING THIS COMMAND WILL DESTROY AND REMOVE %BOX_TYPE% BOX RUNNING!
ECHO ===========================================================================
ECHO.

SET /P CANCEL="TO EXIT ENTER 'N' OTHERWISE ENTER 'Y' TO CONTINUE:"

IF /I "%CANCEL%" == "N" GOTO END
IF /I "%CANCEL%" == "Y" GOTO CONTINUE

:END
ECHO YOU ARE NOW EXITING!
EXIT /B

:CONTINUE
ECHO LISTING ALL RUNNING BOXES.
vagrant.exe box list

SET /P REMOVE=REMOVING %BOX_TYPE% ARE YOU SURE?[Y/N]

IF /I "%REMOVE%" == "Y" GOTO :REMOVE
IF /I "%REMOVE%" == "N" GOTO :END

:REMOVE
vagrant.exe destroy -f
vagrant.exe box remove %BOX_TYPE%

ENDLOCAL

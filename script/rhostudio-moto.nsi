;======================================================
; Include
 
  !include "MUI.nsh"
  !include "LogicLib.nsh"
  !include "%NSIS_SCRIPT_PATH%\EnvVarUpdate.nsh"
 
;======================================================
; Installer Information
 
  Name "Motorola RhoMobile Suite"
  OutFile "RMS_.exe"
  InstallDir "C:\MotorolaRhoMobileSuite%NSIS_VERSION%"
  BrandingText " "
;======================================================
; Modern Interface Configuration
 
  !define MUI_ICON "rho_rhosuite.ico"
  !define MUI_UNICON "rho_rhosuite.ico"
  !define MUI_HEADERIMAGE
  !define MUI_ABORTWARNING
  !define MUI_COMPONENTSPAGE_SMALLDESC
  !define MUI_FINISHPAGE_SHOWREADME $INSTDIR\README.html
  !define MUI_FINISHPAGE
  !define MUI_FINISHPAGE_TEXT "Thank you for installing RhoElements, RhoConnect and RhoStudio. \r\n\n\n"
  !define MUI_WELCOMEFINISHPAGE_BITMAP "..\script\images\rhosuite_left.bmp"
  !define MUI_HEADERIMAGE_BITMAP  "..\script\images\rhosuite_top.bmp"
  !define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
 
;======================================================
; Pages
 
  !define MUI_WELCOMEPAGE_TEXT "© 2014 Motorola Solutions, Inc. All rights reserved.\r\n\r\n$(MUI_${MUI_PAGE_UNINSTALLER_PREFIX}TEXT_WELCOME_INFO_TEXT)"
  !insertmacro MUI_PAGE_WELCOME
  !define MUI_PAGE_HEADER_TEXT "Motorola RhoMobile Suite License Agreement"
  !define MUI_PAGE_HEADER_SUBTEXT "Please review the Motorola RhoMobile Suite license terms before installing."
  !insertmacro MUI_PAGE_LICENSE "RHOELEMENTS-EULA.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !define MUI_PAGE_CUSTOMFUNCTION_LEAVE directoryPostFunction
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
 
;======================================================
; Languages
 
  !insertmacro MUI_LANGUAGE "English"
 
;======================================================
; Reserve Files
 
  ;ReserveFile "%NSIS_SCRIPT_PATH%\configUi.ini"
  ;!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

;======================================================
; Variables

;======================================================
; Sections

# start default section
section

    SetShellVarContext all

    ReadRegStr $0 HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\Motorola RhoMobile Suite" "UninstallString" 

    StrCmp $0 "" continueInstallation

    MessageBox MB_OK|MB_ICONINFORMATION|MB_DEFBUTTON1 "Motorola RhoMobile Suite is already installed. Please uninstall the previous version before installing this one."
    Quit 

    continueInstallation:

    # check install JRE or not, if not show message box and exit from installer
    ReadRegStr $0 HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\javaws.exe" "Path"
              
    StrCmp $0 "" jreInstallFail   

    # set the installation directory as the destination for the following actions
    setOutPath $INSTDIR
 
    # copy rhoconnect files on destination computer for manual installation
    File /r "rhoconnect-push"

    # create the uninstaller
    writeUninstaller "$INSTDIR\uninstall.exe"
 
    SetOutPath "$SMPROGRAMS\Motorola RhoMobile Suite"
    
    # create a shortcut named "new shortcut" in the start menu programs directory
    # point the new shortcut at the program uninstaller
    createShortCut "$SMPROGRAMS\Motorola RhoMobile Suite\Uninstall RhoMobile Suite.lnk" "$INSTDIR\uninstall.exe"
    createShortCut "$SMPROGRAMS\Motorola RhoMobile Suite\Motorola RhoStudio 32-bit.lnk" "$INSTDIR\rhostudio\win32.win32.x86\RhoStudio.exe"
    createShortCut "$SMPROGRAMS\Motorola RhoMobile Suite\Motorola RhoStudio 64-bit.lnk" "$INSTDIR\rhostudio\win32.win32.x86_64\RhoStudio.exe" "" "$INSTDIR\rhostudio\win32.win32.x86\RhoStudio.exe" 0
    createShortCut "$SMPROGRAMS\Motorola RhoMobile Suite\Runtimes For Rhoconnect-push service.lnk"  "$windir\explorer.exe" '/e,"$INSTDIR\rhoconnect-push-service"' 
    createShortCut "$SMPROGRAMS\Motorola RhoMobile Suite\Printing service.lnk"  "$windir\explorer.exe" '/e,"$INSTDIR\printing-service"' 
    createShortCut "$SMPROGRAMS\Motorola RhoMobile Suite\Readme.lnk" "$INSTDIR\README.html"
    createShortCut "$SMPROGRAMS\Motorola RhoMobile Suite\Developer Community.lnk" "http://launchpad.motorolasolutions.com" "" "$PROGRAMFILES\Internet Explorer\IEXPLORE.EXE" 0
    createShortCut "$SMPROGRAMS\Motorola RhoMobile Suite\Documentation.lnk" "http://docs.rhomobile.com/" "" "$PROGRAMFILES\Internet Explorer\IEXPLORE.EXE" 0

    # added information in 'unistall programs' in contorol panel
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Motorola RhoMobile Suite" \
                 "DisplayName" "Motorola RhoMobile Suite"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Motorola RhoMobile Suite" \
                 "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Motorola RhoMobile Suite" \
                 "DisplayIcon" "$\"$INSTDIR\uninstall.exe$\""
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Motorola RhoMobile Suite" \
                 "Publisher" "Motorola Solutions Inc."
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Motorola RhoMobile Suite" \
                 "DisplayVersion" "%RHOMOBILE_SUITE_VER%"  
    WriteRegDWORD  HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Motorola RhoMobile Suite" \
                 "NoRepair" 1
      
    Goto okFinishSection
    
    jreInstallFail:
        MessageBox MB_OK|MB_ICONINFORMATION|MB_DEFBUTTON1 "Java Runtime Environment could not be found on your computer. Please install Java Runtime Environment before RhoStudio."
        Quit 

    okFinishSection: 
sectionEnd
 
# uninstaller section start
section "uninstall"

    IfSilent +3
      MessageBox MB_YESNO|MB_TOPMOST|MB_ICONQUESTION "Are you sure you want to uninstall Motorola RhoMobile Suite" IDNO "Continue"    

    SetShellVarContext all

    # first, delete the uninstaller
    delete "$INSTDIR\uninstall.exe"
 
    # second, remove the link from the start menu    
    delete "$SMPROGRAMS\Motorola RhoMobile Suite\Uninstall RhoMobile Suite.lnk"
    delete "$SMPROGRAMS\Motorola RhoMobile Suite\Motorola RhoStudio 32-bit.lnk"
    delete "$SMPROGRAMS\Motorola RhoMobile Suite\Motorola RhoStudio 64-bit.lnk"
    delete "$SMPROGRAMS\Motorola RhoMobile Suite\Readme.lnk"
    delete "$SMPROGRAMS\Motorola RhoMobile Suite\Developer Community.lnk"
    delete "$SMPROGRAMS\Motorola RhoMobile Suite\Documentation.lnk"
    delete "$SMPROGRAMS\Motorola RhoMobile Suite\Runtimes For Rhoconnect-push service.lnk"
    delete "$SMPROGRAMS\Motorola RhoMobile Suite\Printing service.lnk"
    delete "$SMPROGRAMS\Motorola RhoMobile Suite\"

    ExecWait 'net stop redis'
    ExecWait 'sc delete redis'

    # remove env vars
    Push "PATH" 
    Push "R" 
    Push "HKLM" 
    Push "$INSTDIR\ruby\bin"
    Call un.EnvVarUpdate
    Pop $R0

    Push "PATH" 
    Push "R" 
    Push "HKLM" 
    Push "$INSTDIR\make-3.81\bin"
    Call un.EnvVarUpdate
    Pop $R0

    Push "PATH" 
    Push "R" 
    Push "HKLM" 
    Push "$INSTDIR\redis-2.4.0"
    Call un.EnvVarUpdate
    Pop $R0

    Push "PATH" 
    Push "R" 
    Push "HKLM" 
    Push "$INSTDIR\devkit\mingw\bin"
    Call un.EnvVarUpdate
    Pop $R0

    Push "PATH" 
    Push "R" 
    Push "HKLM" 
    Push "$INSTDIR\devkit\bin"
    Call un.EnvVarUpdate
    Pop $R0

    DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" REDIS_HOME
    DeleteRegKey HKLM  "Software\Microsoft\Windows\CurrentVersion\Uninstall\Motorola RhoMobile Suite"

    # remove $INSTDIR
    RMDir /r /REBOOTOK $INSTDIR

    Continue: 
      Quit

# uninstaller section end
sectionEnd

Section "GNU Make" gnumakeSection

  SetOutPath $INSTDIR
 
  File /r "make-3.81"

  Push "PATH" 
  Push "P" 
  Push "HKLM" 
  Push "$INSTDIR\make-3.81\bin"
  Call EnvVarUpdate
  Pop $R0

SectionEnd

Section "RhoStudio IDE" studioSection
 
  SetOutPath $INSTDIR
 
  File /r "rhostudio"

SectionEnd

Section "Rhoconnect-push service clients" rhoconnectpushSection
 
  SetOutPath $INSTDIR
 
  File /r "rhoconnect-push-service"

SectionEnd

Section "Printing service" printingserviceSection

  SetOutPath $INSTDIR

  File /r "printing-service"

SectionEnd

Section "Samples" samplesSection
 
  SetOutPath $INSTDIR
 
  File /r "samples"

SectionEnd

Section "rhoapi-modules" rhoapiModulesSection

  SetOutPath $INSTDIR

  File /r "rhoapi-modules"

SectionEnd

Section "DevKit" devkitSection
 
  SetOutPath $INSTDIR
 
  File /r "devkit"

  Push "PATH" 
  Push "P" 
  Push "HKLM" 
  Push "$INSTDIR\devkit\mingw\bin"
  Call EnvVarUpdate
  Pop $R0

  Push "PATH" 
  Push "P" 
  Push "HKLM" 
  Push "$INSTDIR\devkit\bin"
  Call EnvVarUpdate
  Pop $R0
  
SectionEnd

Section "Ruby, Rubygems, Rhodes, RhoConnect and adapters" rubySection
 
  SetOutPath $INSTDIR
 
  File /r "ruby"
  File /r "make-3.81"
  File /r "RhoElements2"

  File "README.html"
  File "RhoStudio and Rho Software License Agreements.doc"
  File "CREDITS"  
 
  ;add to path here

  Push "PATH" 
  Push "P" 
  Push "HKLM" 
  Push "$INSTDIR\ruby\bin"
  Call EnvVarUpdate
  Pop $R0
  
  #ExecWait "$INSTDIR\ruby\bin\rake.bat dtach:install"  

SectionEnd

Section "Redis" redisSection
 
  SetOutPath $INSTDIR
 
  File /r "redis-2.4.0"
 
  ;add to path here

  Push "PATH" 
  Push "P" 
  Push "HKLM" 
  Push "$INSTDIR\redis-2.4.0"
  Call EnvVarUpdate
  Pop $R0

  Push "REDIS_HOME" 
  Push "P" 
  Push "HKLM" 
  Push "$INSTDIR\redis-2.4.0"
  Call EnvVarUpdate
  Pop $R0

  ExecWait "$INSTDIR\ruby\bin\rake.bat redis:install"
  
SectionEnd

Section "Git 1.7.6" gitSection

  SetOutPath $INSTDIR
  
  File "Git-1.7.6-preview20110708.exe"
 
  IfSilent +3
    ExecWait "$INSTDIR\Git-1.7.6-preview20110708.exe"
  Goto +2
    ExecWait "$INSTDIR\Git-1.7.6-preview20110708.exe /silent"

  delete "$INSTDIR\Git-1.7.6-preview20110708.exe"

SectionEnd


Section "Node JS 0.8.1" nodeSection

  SetOutPath $INSTDIR
 
  IfSilent +3
    ExecWait "msiexec.exe /i $INSTDIR\rhoconnect-push\node-v0.8.1-x86.msi"
  Goto +2
    ExecWait "msiexec.exe /passive /i $INSTDIR\rhoconnect-push\node-v0.8.1-x86.msi"

  ReadRegStr $0 HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path"

  ReadEnvStr $R0 "PATH"
  StrCpy $R0 "$R0;$0"
  System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("PATH", R0).r0'
                                   
  ExecWait "$INSTDIR\rhoconnect-push\patch.bat"

SectionEnd

;======================================================
;Descriptions
 
  ;Language strings
  LangString DESC_InstallRhostudio ${LANG_ENGLISH} "This installs Eclipse with RhoStudio IDE."
  LangString DESC_InstallRuby ${LANG_ENGLISH} "This installs ruby 1.8.7, rubygems 1.3.7, Rhodes, RhoConnect and adapters"
  LangString DESC_InstallRedis ${LANG_ENGLISH} "This installs redis 2.2.2 (required to run RhoConnect)."
  LangString DESC_InstallGit ${LANG_ENGLISH} "This installs Git (which includes the Git Bash)."
  LangString DESC_InstallGnuMake ${LANG_ENGLISH} "This installs GNU Make (sometimes required to update gems)."
  LangString DESC_InstallSamples ${LANG_ENGLISH} "This installs samples for Rhodes."
  LangString DESC_InstallRhoapiModules ${LANG_ENGLISH} "This installs universal rhoapi-modules.js solution."
  LangString DESC_InstallDevKit ${LANG_ENGLISH} "This installs development kit for application building."  
  LangString DESC_InstallNodeJs ${LANG_ENGLISH} "This installs Node for JavaScript."  
  LangString DESC_InstallRhoconnectPush ${LANG_ENGLISH} "This installs Rhoconnect-push service clients."  
  LangString DESC_InstallPrintingService ${LANG_ENGLISH} "This installs printing service."
  
  ;Assign language strings to sections
  
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${studioSection} $(DESC_InstallRhostudio)
  !insertmacro MUI_DESCRIPTION_TEXT ${gnumakeSection} $(DESC_InstallGnuMake)
  !insertmacro MUI_DESCRIPTION_TEXT ${devkitSection} $(DESC_InstallDevKit)
  !insertmacro MUI_DESCRIPTION_TEXT ${rubySection} $(DESC_InstallRuby) 
  !insertmacro MUI_DESCRIPTION_TEXT ${redisSection} $(DESC_InstallRedis)
  !insertmacro MUI_DESCRIPTION_TEXT ${gitSection} $(DESC_InstallGit)
  !insertmacro MUI_DESCRIPTION_TEXT ${samplesSection} $(DESC_InstallSamples)
  !insertmacro MUI_DESCRIPTION_TEXT ${rhoapiModulesSection} $(DESC_InstallRhoapiModules)
  !insertmacro MUI_DESCRIPTION_TEXT ${rhoconnectpushSection} $(DESC_InstallRhoconnectPush)
  !insertmacro MUI_DESCRIPTION_TEXT ${printingserviceSection} $(DESC_InstallPrintingService)
  !insertmacro MUI_DESCRIPTION_TEXT ${nodeSection} $(DESC_InstallNodeJs)
  #!insertmacro MUI_DESCRIPTION_TEXT ${javaSection} $(DESC_InstallJava)    
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;======================================================
;Functions

Function relGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
 
  Move:
    SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd

Function directoryPostFunction

  # check spaces in install path, if path contain spaces show message box and exit from installer
  ${StrStr} $0 $INSTDIR " "

  StrLen $1 $0

  ${If} $1 != 0
    MessageBox MB_YESNO|MB_ICONINFORMATION|MB_DEFBUTTON1 "Please choose a path without spaces. Ruby will not work properly in a path with spaces. Press 'Yes' to change install path or 'No' to exit from the installer." IDNO "failChangeInstallPath" IDYES "changeIsOk"
  ${Else}
    return
  ${EndIf}
    
  failChangeInstallPath:
    Quit

  changeIsOk:
    StrCpy $R9 "(-1|X)" ;Relative page number. See below.
    Call relGotoPage

FunctionEnd

Function FixScriptFilesInDir
Exch $R0 #path
Exch
Exch $R1 #filter
Exch
Exch 2
Exch $R2 #output file
Exch 2
Push $R3
Push $R4
Push $R5
Push $R6
 ClearErrors
 FindFirst $R3 $R4 "$R0\$R1"
  FileOpen $R5 $R2 w

 Push $INSTDIR
 Push "\"
 Call StrSlash
 Pop $R6 

 Loop:
 IfErrors Done
  StrCmp $R4 "." gotoNextFile
  StrCmp $R4 ".." gotoNextFile

  ;replace package folder with INSTDIR
  Push C:/dev/rhodesinstaller
  Push $R6
  Push all
  Push all
  Push "$R0\$R4"
  Call AdvReplaceInFile
  FileWrite $R5 "$R0\$R4$\r$\n"
  FindNext $R3 $R4
  Goto Loop

 gotoNextFile:
  FindNext $R3 $R4
  Goto Loop

 Done:
  FileClose $R5
 FindClose $R3
Pop $R6
Pop $R5
Pop $R4
Pop $R3
Pop $R2
Pop $R1
Pop $R0
FunctionEnd



Function AdvReplaceInFile
Exch $0 ;file to replace in
Exch
Exch $1 ;number to replace after
Exch
Exch 2
Exch $2 ;replace and onwards
Exch 2
Exch 3
Exch $3 ;replace with
Exch 3
Exch 4
Exch $4 ;to replace
Exch 4
Push $5 ;minus count
Push $6 ;universal
Push $7 ;end string
Push $8 ;left string
Push $9 ;right string
Push $R0 ;file1
Push $R1 ;file2
Push $R2 ;read
Push $R3 ;universal
Push $R4 ;count (onwards)
Push $R5 ;count (after)
Push $R6 ;temp file name
 
  GetTempFileName $R6
  FileOpen $R1 $0 r ;file to search in
  FileOpen $R0 $R6 w ;temp file
   StrLen $R3 $4
   StrCpy $R4 -1
   StrCpy $R5 -1
 
loop_read:
 ClearErrors
 FileRead $R1 $R2 ;read line
 IfErrors exit
 
   StrCpy $5 0
   StrCpy $7 $R2
 
loop_filter:
   IntOp $5 $5 - 1
   StrCpy $6 $7 $R3 $5 ;search
   StrCmp $6 "" file_write2
   StrCmp $6 $4 0 loop_filter
 
StrCpy $8 $7 $5 ;left part
IntOp $6 $5 + $R3
IntCmp $6 0 is0 not0
is0:
StrCpy $9 ""
Goto done
not0:
StrCpy $9 $7 "" $6 ;right part
done:
StrCpy $7 $8$3$9 ;re-join
 
IntOp $R4 $R4 + 1
StrCmp $2 all file_write1
StrCmp $R4 $2 0 file_write2
IntOp $R4 $R4 - 1
 
IntOp $R5 $R5 + 1
StrCmp $1 all file_write1
StrCmp $R5 $1 0 file_write1
IntOp $R5 $R5 - 1
Goto file_write2
 
file_write1:
 FileWrite $R0 $7 ;write modified line
Goto loop_read
 
file_write2:
 FileWrite $R0 $R2 ;write unmodified line
Goto loop_read
 
exit:
  FileClose $R0
  FileClose $R1
 
   SetDetailsPrint none
  Delete $0
  Rename $R6 $0
  Delete $R6
   SetDetailsPrint both
 
Pop $R6
Pop $R5
Pop $R4
Pop $R3
Pop $R2
Pop $R1
Pop $R0
Pop $9   
Pop $8
Pop $7
Pop $6
Pop $5
Pop $0
Pop $1
Pop $2
Pop $3
Pop $4
FunctionEnd 


; Push $filenamestring (e.g. 'c:\this\and\that\filename.htm')
; Push "\"
; Call StrSlash
; Pop $R0
; ;Now $R0 contains 'c:/this/and/that/filename.htm'
Function StrSlash
  Exch $R3 ; $R3 = needle ("\" or "/")
  Exch
  Exch $R1 ; $R1 = String to replacement in (haystack)
  Push $R2 ; Replaced haystack
  Push $R4 ; $R4 = not $R3 ("/" or "\")
  Push $R6
  Push $R7 ; Scratch reg
  StrCpy $R2 ""
  StrLen $R6 $R1
  StrCpy $R4 "\"
  StrCmp $R3 "/" loop
  StrCpy $R4 "/"  
loop:
  StrCpy $R7 $R1 1
  StrCpy $R1 $R1 $R6 1
  StrCmp $R7 $R3 found
  StrCpy $R2 "$R2$R7"
  StrCmp $R1 "" done loop
found:
  StrCpy $R2 "$R2$R4"
  StrCmp $R1 "" done loop
done:
  StrCpy $R3 $R2
  Pop $R7
  Pop $R6
  Pop $R4
  Pop $R2
  Pop $R1
  Exch $R3
FunctionEnd

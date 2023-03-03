Unicode true

####################################################################
# Includes

!include MUI2.nsh
!include FileFunc.nsh
!include LogicLib.nsh

!insertmacro Locate
Var /GLOBAL switch_overwrite
!include MoveFileFolder.nsh

####################################################################
# File Info

!define PRODUCT_NAME "Extravi's ReShade-Preset"
!define PRODUCT_DESCRIPTION "ReShade presets made by Extravi."
!define COPYRIGHT "Copyright © 2022 sitiom, Extravi"
!define VERSION "4.3.1"

VIProductVersion "${VERSION}.0"
VIAddVersionKey "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey "ProductVersion" "${VERSION}"
VIAddVersionKey "FileDescription" "${PRODUCT_DESCRIPTION}"
VIAddVersionKey "LegalCopyright" "${COPYRIGHT}"
VIAddVersionKey "FileVersion" "${VERSION}.0"

####################################################################
# Installer Attributes

ManifestDPIAware true

Name "${PRODUCT_NAME}"
Outfile "Setup - ${PRODUCT_NAME}.exe"
Caption "Setup - ${PRODUCT_NAME}"
BrandingText "${PRODUCT_NAME}"

RequestExecutionLevel user
 
InstallDir "$LOCALAPPDATA\${PRODUCT_NAME}"

####################################################################
# Interface Settings

InstType "Full";1

####################################################################
# Pages

!define MUI_ICON "extravi-reshade.ico"
!define MUI_UNICON "extravi-reshade.ico"
!define MUI_ABORTWARNING
!define MUI_WELCOMEFINISHPAGE_BITMAP "extravi-reshade.bmp"
!define MUI_WELCOMEPAGE_TEXT "This will install ${PRODUCT_NAME} on your computer.$\r$\n\
$\r$\n\
Before continuing, ensure that Roblox is closed. If Roblox is open, the installer will terminate the process before it begins.$\r$\n\
$\r$\n\
There may be issues with the setup. If that's the case, it's recommended that you ask your questions in Extravi's Discord server.$\r$\n\
$\r$\n\
Click Next to continue."
!define MUI_LICENSEPAGE_RADIOBUTTONS
!define MUI_COMPONENTSPAGE_NODESC
!define MUI_FINISHPAGE_TEXT_LARGE
!define MUI_FINISHPAGE_TEXT "Setup has finished installing ${PRODUCT_NAME} on your computer. The effects will be applied the next time you launch Roblox.$\r$\n\
$\r$\n\
Click Finish to exit Setup."
!define MUI_FINISHPAGE_SHOWREADME "https://reshade.me/"
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Visit reshade.me"
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Subscribe to Extravi on Youtube"
!define MUI_FINISHPAGE_RUN_CHECKED
!define MUI_FINISHPAGE_RUN_FUNCTION "OpenLink"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "Extravi's ReShade-Preset\license.txt"
!insertmacro MUI_PAGE_COMPONENTS
!define MUI_PAGE_CUSTOMFUNCTION_SHOW "StartTaskbarProgress"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

####################################################################
# Language

!insertmacro MUI_LANGUAGE "English"

####################################################################
# Sections

Var robloxPath

Section "ReShade (required)"
  SectionIn 1 RO

  ExecWait "TaskKill /IM RobloxPlayerBeta.exe /F"
  
  SetOutPath $INSTDIR

  WriteUninstaller "$INSTDIR\uninstall.exe"

  ; Uninstall Regkeys
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayIcon" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "DisplayVersion" "${VERSION}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "QuietUninstallString" "$INSTDIR\uninstall.exe /S"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets" "Publisher" "Extravi"

  NSCurl::http GET "https://github.com/BlueSkyDefender/AstrayFX/archive/f3f55f08c874ba4b01835cd4615e2b6f5b2459c5.zip" /END
  nsisunz::Unzip "AstrayFX-f3f55f08c874ba4b01835cd4615e2b6f5b2459c5.zip" "$INSTDIR"
  Delete "AstrayFX-f3f55f08c874ba4b01835cd4615e2b6f5b2459c5.zip"

  NSCurl::http GET "https://github.com/BlueSkyDefender/Depth3D/archive/684048e18fa2d216d83f658c6e1962d3c8c74cc5.zip" "Depth3D-master.zip" /END
  nsisunz::Unzip "Depth3D-684048e18fa2d216d83f658c6e1962d3c8c74cc5.zip" "$INSTDIR"
  Delete "Depth3D-684048e18fa2d216d83f658c6e1962d3c8c74cc5.zip"

  NSCurl::http GET "https://github.com/crosire/reshade-shaders/archive/9fbec45aa73aead72b00eb3ba3f9373220183256.zip" "reshade-shaders-master.zip" /END
  nsisunz::Unzip "reshade-shaders-9fbec45aa73aead72b00eb3ba3f9373220183256.zip" "$INSTDIR"
  Delete "reshade-shaders-9fbec45aa73aead72b00eb3ba3f9373220183256.zip"

  NSCurl::http GET "https://github.com/prod80/prod80-ReShade-Repository/archive/1c2ed5b093b03c558bfa6aea45c2087052e99554.zip" "prod80-ReShade-Repository-master.zip" /END
  nsisunz::Unzip "prod80-ReShade-Repository-1c2ed5b093b03c558bfa6aea45c2087052e99554.zip" "$INSTDIR"
  Delete "prod80-ReShade-Repository-1c2ed5b093b03c558bfa6aea45c2087052e99554.zip"
  
  NSCurl::http GET "https://github.com/martymcmodding/qUINT/archive/b38f7e16fc7094b49dd729f3b66edd08e7ac7204.zip" "qUINT-master.zip" /END
  nsisunz::Unzip "qUINT-b38f7e16fc7094b49dd729f3b66edd08e7ac7204.zip" "$INSTDIR"
  Delete "qUINT-b38f7e16fc7094b49dd729f3b66edd08e7ac7204.zip"

  NSCurl::http GET "https://github.com/AlucardDH/dh-reshade-shaders/archive/c81af4b2c9a5bde68ad975e32165ec9406ec59c3.zip" "dh-reshade-shaders-master.zip" /END
  nsisunz::Unzip "dh-reshade-shaders-c81af4b2c9a5bde68ad975e32165ec9406ec59c3.zip" "$INSTDIR"
  Delete "dh-reshade-shaders-c81af4b2c9a5bde68ad975e32165ec9406ec59c3.zip"

  NSCurl::http GET "https://github.com/rj200/Glamarye_Fast_Effects_for_ReShade/archive/c078b922c91a775d3940399bf48bf01e83529891.zip" "Glamarye_Fast_Effects_for_ReShade-main.zip" /END
  nsisunz::Unzip "Glamarye_Fast_Effects_for_ReShade-c078b922c91a775d3940399bf48bf01e83529891" "$INSTDIR"
  Delete "Glamarye_Fast_Effects_for_ReShade-c078b922c91a775d3940399bf48bf01e83529891"

  NSCurl::http GET "https://github.com/mj-ehsan/NiceGuy-Shaders/archive/d12926f09a13013bfb6bd54bf0eeba10df9c2f08.zip" "NiceGuy-Shaders-main.zip" /END
  nsisunz::Unzip "NiceGuy-Shaders-d12926f09a13013bfb6bd54bf0eeba10df9c2f08.zip" "$INSTDIR"
  Delete "NiceGuy-Shaders-d12926f09a13013bfb6bd54bf0eeba10df9c2f08.zip"

  StrCpy $switch_overwrite 1 $INSTDIR

  RMDir /r "$robloxPath\reshade-presets"
  RMDir /r "$robloxPath\reshade-shaders"
  RMDir /r "$robloxPath\ClientSettings"
  Delete "$robloxPath\Reshade.ini"
  Delete "$robloxPath\dxgi.dll"
  Delete "$robloxPath\reshade.dll"

  !insertmacro MoveFolder "$INSTDIR\AstrayFX-f3f55f08c874ba4b01835cd4615e2b6f5b2459c5\Shaders" "$robloxPath\reshade-shaders\Shaders\AstrayFX" "*"
  !insertmacro MoveFolder "$INSTDIR\AstrayFX-f3f55f08c874ba4b01835cd4615e2b6f5b2459c5\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\AstrayFX-f3f55f08c874ba4b01835cd4615e2b6f5b2459c5"
  Delete "$robloxPath\reshade-shaders\Shaders\AstrayFX\Clarity.fx"

  !insertmacro MoveFolder "$INSTDIR\Depth3D-684048e18fa2d216d83f658c6e1962d3c8c74cc5\Shaders" "$robloxPath\reshade-shaders\Shaders\Depth3D" "*"
  !insertmacro MoveFolder "$INSTDIR\Depth3D-684048e18fa2d216d83f658c6e1962d3c8c74cc5\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\Depth3D-684048e18fa2d216d83f658c6e1962d3c8c74cc5"

  !insertmacro MoveFolder "$INSTDIR\reshade-shaders-9fbec45aa73aead72b00eb3ba3f9373220183256\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "$INSTDIR\reshade-shaders-9fbec45aa73aead72b00eb3ba3f9373220183256\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\reshade-shaders-9fbec45aa73aead72b00eb3ba3f9373220183256"

  !insertmacro MoveFolder "$INSTDIR\prod80-ReShade-Repository-1c2ed5b093b03c558bfa6aea45c2087052e99554\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "$INSTDIR\prod80-ReShade-Repository-1c2ed5b093b03c558bfa6aea45c2087052e99554\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\prod80-ReShade-Repository-1c2ed5b093b03c558bfa6aea45c2087052e99554"

  !insertmacro MoveFolder "$INSTDIR\qUINT-b38f7e16fc7094b49dd729f3b66edd08e7ac7204\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  RMDir /r "$INSTDIR\qUINT-b38f7e16fc7094b49dd729f3b66edd08e7ac7204"

  !insertmacro MoveFolder "$INSTDIR\dh-reshade-shaders-c81af4b2c9a5bde68ad975e32165ec9406ec59c3\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  !insertmacro MoveFolder "$INSTDIR\dh-reshade-shaders-c81af4b2c9a5bde68ad975e32165ec9406ec59c3\Textures" "$robloxPath\reshade-shaders\Textures" "*"
  RMDir /r "$INSTDIR\dh-reshade-shaders-c81af4b2c9a5bde68ad975e32165ec9406ec59c3"
  Delete "$robloxPath\reshade-shaders\Shaders\dh_Lain.fx"
  Delete "$robloxPath\reshade-shaders\Shaders\dh_rtgi.fx"

  !insertmacro MoveFolder "$INSTDIR\Glamarye_Fast_Effects_for_ReShade-c078b922c91a775d3940399bf48bf01e83529891\Shaders" "$robloxPath\reshade-shaders\Shaders" "*"
  RMDir /r "$INSTDIR\Glamarye_Fast_Effects_for_ReShade-c078b922c91a775d3940399bf48bf01e83529891"

  !insertmacro MoveFolder "$INSTDIR\NiceGuy-Shaders-d12926f09a13013bfb6bd54bf0eeba10df9c2f08" "$robloxPath\reshade-shaders" "*"
  RMDir /r "$INSTDIR\NiceGuy-Shaders-d12926f09a13013bfb6bd54bf0eeba10df9c2f08"

  NSCurl::http GET "https://github.com/Extravi/extravi.github.io/raw/main/update/dxgi.zip" "dxgi.zip" /END
  nsisunz::Unzip "dxgi.zip" "$robloxPath"
  Delete "dxgi.zip"

  NSCurl::http GET "https://github.com/Extravi/extravi.github.io/raw/main/update/config.zip" "config.zip" /END
  nsisunz::Unzip "config.zip" "$robloxPath"
  Delete "config.zip"

  SetOutPath $robloxPath
SectionEnd

SectionGroup /e "Presets"
  Section "Extravi's ReShade-Presets"
    SectionIn 1
    NSCurl::http GET "https://github.com/Extravi/extravi.github.io/raw/main/update/reshade-presets.zip" "reshade-presets.zip" /END
    nsisunz::Unzip "reshade-presets.zip" "$robloxPath"
    Delete "reshade-presets.zip"
  SectionEnd
SectionGroupEnd

SectionGroup /e "rbxfpsunlocker"
  Section "rbxfpsunlocker"
   SectionIn 1
   ExecWait "TaskKill /IM rbxfpsunlocker.exe /F"
   NSCurl::http GET "https://github.com/axstin/rbxfpsunlocker/releases/latest/download/rbxfpsunlocker-x64.zip" "rbxfpsunlocker-x64.zip" /END
   nsisunz::Unzip "rbxfpsunlocker-x64.zip" "$INSTDIR"
   Delete "rbxfpsunlocker-x64.zip"
   CreateShortCut "$DESKTOP\Roblox FPS Unlocker.lnk" "$INSTDIR\rbxfpsunlocker.exe"
   CreateShortCut "$SMPROGRAMS\Roblox FPS Unlocker.lnk" "$INSTDIR\rbxfpsunlocker.exe"
   RMDir /r "$robloxPath\r"
   Exec "$INSTDIR\rbxfpsunlocker.exe"
  SectionEnd
SectionGroupEnd

Section "uninstall"
  ${Locate} "$LOCALAPPDATA\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "un.SetRobloxPath"

  ExecWait "TaskKill /IM RobloxPlayerBeta.exe /F"
  ExecWait "TaskKill /IM rbxfpsunlocker.exe /F"
  Delete "$INSTDIR\rbxfpsunlocker.exe"
  Delete "$INSTDIR\settings"
  Delete "$robloxPath\settings"
  Delete "$INSTDIR\uninstall.exe"
  RMDir /r $INSTDIR

  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\extravi-reshade-presets"

  Delete "$robloxPath\ReShade.ini"
  RMDir /r "$robloxPath\reshade-presets"
  RMDir /r "$robloxPath\reshade-shaders"
  RMDir /r "$robloxPath\ClientSettings"
  Delete "$robloxPath\dxgi.dll"
  Delete "$robloxPath\ReShade.log"
  Delete "$robloxPath\NunitoSans-Regular.ttf"
  Delete "$robloxPath\Hack-Regular.ttf"
  Delete "$DESKTOP\Roblox FPS Unlocker.lnk"
  Delete "$SMPROGRAMS\Roblox FPS Unlocker.lnk"
  Delete "$robloxPath\license.txt"
SectionEnd

####################################################################
# Functions

Function .onInit
  ${Locate} "$PROGRAMFILES\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "Troubleshoot"

  StrCpy $robloxPath ""
  ${Locate} "$LOCALAPPDATA\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "SetRobloxPath"  
  
  ${If} $robloxPath == ""
    MessageBox MB_YESNO|MB_ICONEXCLAMATION "Roblox installation not found. Would you like to reinstall Roblox and try again?" IDYES yes
    Abort
    yes:
    NScurl::http GET "https://www.roblox.com/download/client" "$INSTDIR\RobloxPlayerLauncher.exe" /POPUP /END
    ExecWait "$INSTDIR\RobloxPlayerLauncher.exe"
    MessageBox MB_ICONQUESTION "Roblox has been reinstalled, if that does not seem to be the case, please check your User Account Control settings."
    RMDir /r $INSTDIR
    Abort
  ${EndIf}
FunctionEnd

Function "Troubleshoot"
    MessageBox MB_YESNO|MB_ICONEXCLAMATION "It seems like Roblox is installed system-wide in the Program Files directory. Would you like to attempt to install again under your own user? Make sure you follow all on-screen instructions, and ensure that Roblox is closed before proceeding." IDYES yes
    Abort
    yes:
    ExecWait "TaskKill /IM RobloxPlayerBeta.exe /F"
    MessageBox MB_ICONQUESTION `A User Account Control pop-up will appear, make sure to click "YES".`
    ${Locate} "$PROGRAMFILES\Roblox\Versions" "/L=F /M=RobloxPlayerBeta.exe" "SetRobloxPath"
    ExecWait '"$robloxPath\RobloxPlayerLauncher.exe"" -uninstall'
    MessageBox MB_ICONQUESTION "Roblox was removed from C:\Program Files (x86). Now will, attempt to reinstall Roblox."
    NScurl::http GET "https://www.roblox.com/download/client" "$INSTDIR\RobloxPlayerLauncher.exe" /POPUP /END
    ExecWait "$INSTDIR\RobloxPlayerLauncher.exe"
    MessageBox MB_ICONQUESTION "Roblox has been reinstalled, if that does not seem to be the case, please check your User Account Control settings."
    RMDir /r $INSTDIR
  Abort
FunctionEnd

Function "SetRobloxPath"
  SetOutPath $R8
  StrCpy $robloxPath $R8
  StrCpy $0 StopLocate
  Push $0
FunctionEnd
Function "un.SetRobloxPath"
  SetOutPath $R8
  StrCpy $robloxPath $R8
  StrCpy $0 StopLocate
  Push $0
FunctionEnd

Function "StartTaskbarProgress"
  w7tbp::Start
FunctionEnd

Function "OpenLink"
  ExecShell "open" "https://www.youtube.com/channel/UCOZnRzWstxDLyW30TjWEevQ?sub_confirmation=1"
FunctionEnd

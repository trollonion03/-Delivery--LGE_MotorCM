Unicode true
 
; headers
!include "MUI2.nsh" 
!include "x64.nsh" 
; define const

!define APP_NAME "LGE_MOTORCM"
!define APP_DIR "MOTORCM_KOR"
!define FILE_VERSION "0.4.2.7"
!define PRODUCT_VERSION "0.4.2.7"
!define MANUFACTURER "LGE"
!define REG_APP_NAME "LGE_MOTORCM"
!define REG_HKLM_UNINST "Software\Microsoft\Windows\CurrentVersion\Uninstall"
 
; metadata

Name "${APP_NAME}"

OutFile "LG_MOTORCM_KOR.exe"

InstallDir "$PROGRAMFILES32\LG_Motor_2022_KOR"

#XPStyle on

#SetCompressor zlib

ShowInstDetails show
 
 
; file descriptions

VIProductVersion "${PRODUCT_VERSION}"
VIAddVersionKey "FileVersion" "${PRODUCT_VERSION}"
VIAddVersionKey "ProductVersion" "${PRODUCT_VERSION}"
VIAddVersionKey "ProductName" "${APP_NAME}"
VIAddVersionKey "CompanyName" "${MANUFACTURER}"
VIAddVersionKey "FileDescription" "NSIS ????"
VIAddVersionKey "LegalCopyright" "LG Electronics."
 
; MUI config

!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\lg.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\nsis3-uninstall.ico"
!define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\nsis3-metro.bmp"
!define MUI_HEADERIMAGE_UNBITMAP "${NSISDIR}\Contrib\Graphics\Header\nsis3-metro-right.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\nsis3-metro.bmp"
!define MUI_WELCOMEFINISHPAGE_UNBITMAP "${NSISDIR}\Contrib\Graphics\Wizard\nsis3-grey.bmp"
 
; inst pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "License.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
 
; uninst pages
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH
 
!insertmacro MUI_LANGUAGE "Korean"
 
Section "main"

SetOutPath "$INSTDIR"

File /r "${APP_DIR}"

${DisableX64FSRedirection}
Exec '"PnPutil.exe" /a "$INSTDIR\${APP_DIR}\Drivers\usb_dev_bulk.inf"'
Exec '"$INSTDIR\${APP_DIR}\labview_installer\setup.exe"'
${EnableX64FSRedirection}
Messagebox MB_OK|MB_ICONINFORMATION \
"Please reconnect the device after installation"
sleep 1000
SectionEnd

Section "-post"

DetailPrint "register uninstall information"

WriteUninstaller "${APP_DIR}\uninstall.exe"

SetShellVarContext all 
CreateDirectory $SMPROGRAMS\LGE_MOTORCM
SetOutPath "$INSTDIR\${APP_DIR}"
CreateShortCut "$SMPROGRAMS\LGE_MOTORCM\MOTORCM_KOR_UNINSTALL.lnk" "$INSTDIR\${APP_DIR}\uninstall.exe"
SetOutPath "$INSTDIR\${APP_DIR}\MotorCM_daemon_Re\program"
CreateShortCut "$SMPROGRAMS\LGE_MOTORCM_KOR.lnk" "$INSTDIR\${APP_DIR}\MotorCM_daemon_Re\program\USBctrl1220_Threaded.exe"

${DisableX64FSRedirection}
Exec '"del" /q "$SMPROGRAMS\Programs\LG_Motor_2022\LG_Motor_v0427_kor.lnk"'
${EnableX64FSRedirection}


WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "DisplayName" "${APP_NAME}"
WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "DisplayIcon" "$INSTDIR\${APP_DIR}\uninstall.exe"
WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "DisplayVersion" "${PRODUCT_VERSION}"
WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "InstallLocation" "$INSTDIR"
WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "Publisher" "${MANUFACTURER}"
WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "UninstallString" "$INSTDIR\${APP_DIR}\uninstall.exe"
SectionEnd
 

Section Uninstall
SectionIn RO
RMDir /r "$INSTDIR\*"
RMDir "$INSTDIR"
SetShellVarContext all
RMDir /r "$STARTMENU\${APP_NAME}"
Delete "$SMPROGRAMS\LGE_MOTORCM_KOR.lnk"
Delete "$SMPROGRAMS\LGE_MOTORCM\TESTAPP_UNINSTALL.lnk"
DeleteRegKey HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}"
SectionEnd
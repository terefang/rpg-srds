#!include "vars.inc"

InstallDir "$PROGRAMFILES\${PROJECT_FINAL_NAME}"

Page directory
Page instfiles

!define UNINSTALLER "$INSTDIR\uninstaller-${PROJECT_FINAL_NAME}.exe"
!define PROJECT_REG_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PROJECT_FINAL_NAME}"
# default section start
Section "install"

# define output path
SetOutPath "$INSTDIR"

# specify file to go in output path
File /r "${PROJECT_APP_DIR}/*"
File "${PROJECT_APP_ICO}"

# define uninstaller name
WriteUninstaller "${UNINSTALLER}"

createDirectory "$SMPROGRAMS\${PROJECT_FINAL_NAME}"
createShortCut "$SMPROGRAMS\${PROJECT_FINAL_NAME}\${PROJECT_FINAL_NAME}.lnk" "$INSTDIR\${PROJECT_APP_EXE}" "" "$INSTDIR\${PROJECT_APP_ICO_NAME}"
createShortCut "$SMPROGRAMS\${PROJECT_FINAL_NAME}\Uninstaller.lnk" "${UNINSTALLER}"

# Registry information for add/remove programs
	WriteRegStr HKLM "${PROJECT_REG_KEY}" "DisplayName" "${PROJECT_FINAL_NAME}"
	WriteRegStr HKLM "${PROJECT_REG_KEY}" "UninstallString" "$\"${UNINSTALLER}$\""
	WriteRegStr HKLM "${PROJECT_REG_KEY}" "QuietUninstallString" "$\"${UNINSTALLER}$\" /S"
	WriteRegStr HKLM "${PROJECT_REG_KEY}" "InstallLocation" "$\"$INSTDIR$\""
	WriteRegStr HKLM "${PROJECT_REG_KEY}" "DisplayVersion" "$\"${PROJECT_VERSION}$\""
	# There is no option for modifying or repairing the install
	WriteRegDWORD HKLM "${PROJECT_REG_KEY}" "NoModify" 1
	WriteRegDWORD HKLM "${PROJECT_REG_KEY}" "NoRepair" 1

#-------
# default section end
SectionEnd

# create a section to define what the uninstaller does.
# the section will always be named "Uninstall"
Section "uninstall"

# Always delete uninstaller first
Delete "${UNINSTALLER}"

# Delete the directory
RMDir /r "$INSTDIR"
RMDir /r "$SMPROGRAMS\${PROJECT_FINAL_NAME}"

DeleteRegKey HKLM "${PROJECT_REG_KEY}"
SectionEnd
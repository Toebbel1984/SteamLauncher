#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\system32\Steam.ico
#AutoIt3Wrapper_Outfile_x64=F:\Steam\SteamLauncher.exe
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Date.au3>
#include <Array.au3>
#include <File.au3>
#include <StringConstants.au3>
#include <D:\Dienste\Own Mgr\Services.au3>

HotKeySet("{ESC}", "MyExit")
_nice_COMerrorHandler(1)
Tweaks()

If ProcessExists("steam.exe") Then
	ShellExecute(_GetSteamExe(), "-shutdown", "", "runas", @SW_HIDE)
	StopSrv()
	MyExit()
Else
	If $CmdLine[0] = 2 Then
		StartSrv()
		$StartOption = IniRead(@ScriptDir & "\steamlauncher.ini", "SETTINGS", "StartOption", "-silent")
		ShellExecute(_GetSteamExe(), $StartOption & " -login " & $CmdLine[1] & " " & $CmdLine[2], "", "runas", @SW_HIDE)
		$aList = ProcessList()
		For $i = 1 To $aList[0][0]
			If $aList[$i][0] = "steam.exe" Then
				ProcessSetPriority($aList[$i][1], 4)
			ElseIf $aList[$i][0] = "steamwebhelper.exe" Then
				ProcessSetPriority($aList[$i][1], 0)
			ElseIf $aList[$i][0] = "SteamService.exe" Then
				ProcessSetPriority($aList[$i][1], 1)
			EndIf
		Next
	EndIf
EndIf

MyExit()

Func MyExit()
    Exit
EndFunc

Func _GetSteamExe()
	Local $hSteamExe = RegRead("HKEY_CURRENT_USER\Software\Valve\Steam", "Steamexe")
	If @error Then
		Return SetError(1, 0, 0)
	Else
		$hSteamExe = StringReplace($hSteamExe, "/", "\")
	EndIf
	If FileExists($hSteamExe) Then
		Return $hSteamExe
	Else
		Return SetError(2, 1, 0)
	EndIf
EndFunc

Func _GetSteamPath()
	Local $hSteamDir = RegRead("HKEY_CURRENT_USER\Software\Valve\Steam", "SteamPath")
	If @error Then
		Return SetError(1, 0, 0)
	Else
		$hSteamDir = StringReplace($hSteamDir, "/", "\")
	EndIf
	If FileExists($hSteamDir) Then
		Return $hSteamDir
	Else
		Return SetError(2, 1, 0)
	EndIf
EndFunc

Func StartSrv()
		_SvcSetStartMode("BEService","auto")
		If Not _SvcisRunning("BEService") Then _SvcStart("BEService")
		_SvcSetStartMode("pnkbstrb","auto")
		If Not _SvcisRunning("pnkbstrb") Then _SvcStart("pnkbstrb")
		_SvcSetStartMode("pnkbstra","auto")
		If Not _SvcisRunning("pnkbstra") Then _SvcStart("pnkbstra")
		_SvcSetStartMode("Rockstar Service","auto")
		If Not _SvcisRunning("Rockstar Service") Then _SvcStart("Rockstar Service")
		_SvcSetStartMode("AntiCheatExpert Service","auto")
		If Not _SvcisRunning("AntiCheatExpert Service") Then _SvcStart("AntiCheatExpert Service")
		_SvcSetStartMode("EasyAntiCheat_EOS","auto")
		If Not _SvcisRunning("EasyAntiCheat_EOS") Then _SvcStart("EasyAntiCheat_EOS")
EndFunc

Func StopSrv()
		If _SvcisRunning("BEService") Then _SvcStop("BEService")
		_SvcSetStartMode("BEService","demand")
		If _SvcisRunning("pnkbstrb") Then _SvcStop("pnkbstrb")
		_SvcSetStartMode("pnkbstrb","demand")
		If _SvcisRunning("pnkbstra") Then _SvcStop("pnkbstra")
		_SvcSetStartMode("pnkbstra","demand")
		If _SvcisRunning("Rockstar Service") Then _SvcStop("Rockstar Service")
		_SvcSetStartMode("Rockstar Service","demand")
		If _SvcisRunning("AntiCheatExpert Service") Then _SvcStop("AntiCheatExpert Service")
		_SvcSetStartMode("AntiCheatExpert Service","demand")
		If _SvcisRunning("EasyAntiCheat_EOS") Then _SvcStop("EasyAntiCheat_EOS")
		_SvcSetStartMode("EasyAntiCheat_EOS","demand")
EndFunc

Func Tweaks()
	If RegKeyExists("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps", "") Then
		$aRegKey = _RegEnumKeyEx("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps", 1, "*")
		For $i = 1 To $aRegKey[0]
			RegWrite($aRegKey[$i], "adobeair", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "amd", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "d3d11", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "directx", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "DXSetup", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "microsoft.net", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "msvc redist", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "msvc redistributables", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "net40redist", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "PhysX", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "PhysXRedist", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "Punkbuster", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "uplaylauncher", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "vcredist", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "vcredist2005", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "vcredist2005atl", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "vcredist2008", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "vcredist2010", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "vcredist2033", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "VCx86", "REG_DWORD", 1)
			RegWrite($aRegKey[$i], "VCx64", "REG_DWORD", 1)
			RegDelete($aRegKey[$i], "InstallDescription")
			RegDelete($aRegKey[$i], "InstallSequence")
		Next
	EndIf

	If RegKeyExists("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Valve\Steam\Apps", "") Then
		$bRegKey = _RegEnumKeyEx("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Valve\Steam\Apps", 1, "*")
		For $i = 1 To $bRegKey[0]
			RegWrite($bRegKey[$i], "adobeair", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "amd", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "d3d11", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "directx", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "DXSetup", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "microsoft.net", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "msvc redist", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "msvc redistributables", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "net40redist", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "PhysX", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "PhysXRedist", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "Punkbuster", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "uplaylauncher", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "vcredist", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "vcredist2005", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "vcredist2005atl", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "vcredist2008", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "vcredist2010", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "vcredist2033", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "VCx86", "REG_DWORD", 1)
			RegWrite($bRegKey[$i], "VCx64", "REG_DWORD", 1)
			RegDelete($bRegKey[$i], "InstallDescription")
			RegDelete($bRegKey[$i], "InstallSequence")
		Next
	EndIf

	If RegKeyExists("HKEY_CURRENT_USER\Software\Valve\Steam\Apps", "") Then
		$cRegKey = _RegEnumKeyEx("HKEY_CURRENT_USER\Software\Valve\Steam\Apps", 1, "*")
		For $i = 1 To $cRegKey[0]
			RegWrite($cRegKey[$i], "adobeair", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "amd", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "d3d11", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "directx", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "DXSetup", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "microsoft.net", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "msvc redist", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "msvc redistributables", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "net40redist", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "PhysX", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "PhysXRedist", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "Punkbuster", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "uplaylauncher", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "vcredist", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "vcredist2005", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "vcredist2005atl", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "vcredist2008", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "vcredist2010", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "vcredist2033", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "VCx86", "REG_DWORD", 1)
			RegWrite($cRegKey[$i], "VCx64", "REG_DWORD", 1)
			RegDelete($cRegKey[$i], "InstallDescription")
			RegDelete($cRegKey[$i], "InstallSequence")
		Next
	EndIf

	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\.NET\3.5", "3.5 SP1", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\.NET\3.5 Client Profile", "3.5 Client Profile SP1", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\.NET\4.0", "4.0", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\.NET\4.0 Client Profile", "4.0 Client Profile", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\.NET\4.5.1", "4.5.1", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\.NET\4.5.2", "4.5.2", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\.NET\4.6", "4.6", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\.NET\4.7", "4.7", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\.NET\4.8", "4.8", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\DirectX", "June2010", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\DirectX\Jun2010", "dxsetup", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\OpenAL\2.0.7.0", "2.0.7.0", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\PhysX", "8.09.04", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\PhysX", "9.12.1031", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\PhysX", "9.13.1220", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\PhysX", "9.14.0702", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2005", "x86 SP1", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2005", "x64 SP1", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2008", "x86 SP1", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2008", "x64 SP1", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2010", "x86", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2010", "x64", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2012", "x86 Update 2", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2012", "x64 Update 2", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2012", "x86 Update 4", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2012", "x64 Update 4", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2013", "x86 Update 1", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2013", "x64 Update 1", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2013", "x86 12.0.30501", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2013", "x64 12.0.30501", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2015", "x86 Update 3 14.0.24215.0", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2015", "x64 Update 3 14.0.24215.0", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2017", "x86 14.10.25008.0", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2017", "x64 14.10.25008.0", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2019", "x86", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2019", "x64", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2022", "x86", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\CommonRedist\vcredist\2022", "x64", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\XNA\3.0", "3.0", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\XNA\3.1", "3.1", "REG_DWORD", 1)
	RegWrite("HKLM\SOFTWARE\Wow6432Node\Valve\Steam\Apps\CommonRedist\XNA\4.0", "4.0 Refresh", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\.NET\3.5", "3.5 SP1", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\.NET\3.5 Client Profile", "3.5 Client Profile SP1", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\.NET\4.0", "4.0", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\.NET\4.0 Client Profile", "4.0 Client Profile", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\.NET\4.5.1", "4.5.1", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\.NET\4.5.2", "4.5.2", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\.NET\4.6", "4.6", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\.NET\4.7", "4.7", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\.NET\4.8", "4.8", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\DirectX", "June2010", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\DirectX\Jun2010", "dxsetup", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\OpenAL\2.0.7.0", "2.0.7.0", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\PhysX", "8.09.04", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\PhysX", "9.12.1031", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\PhysX", "9.13.1220", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\PhysX", "9.14.0702", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2005", "x86 SP1", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2005", "x64 SP1", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2008", "x86 SP1", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2008", "x64 SP1", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2010", "x86", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2010", "x64", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2012", "x86 Update 2", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2012", "x64 Update 2", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2012", "x86 Update 4", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2012", "x64 Update 4", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2013", "x86 Update 1", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2013", "x64 Update 1", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2013", "x86 12.0.30501", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2013", "x64 12.0.30501", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2015", "x86 Update 3 14.0.24215.0", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2015", "x64 Update 3 14.0.24215.0", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2017", "x86 14.10.25008.0", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2017", "x64 14.10.25008.0", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2019", "x86", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2019", "x64", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2022", "x86", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\vcredist\2022", "x64", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\XNA\3.0", "3.0", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\XNA\3.1", "3.1", "REG_DWORD", 1)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam\Apps\CommonRedist\XNA\4.0", "4.0 Refresh", "REG_DWORD", 1)
EndFunc

Func RegKeyExists($sKeyname, $sValueName)
    Return (RegRead($sKeyname, $sValueName) == "" ? False : True)
EndFunc

Func _RegEnumKeyEx($KeyName, $iFlag = 0, $sFilter = "*", $vFilter = "*", $iValueTypes = 0)
	If StringRegExp($sFilter, StringReplace("^\s*$|\v|\\|^\||\|\||\|$", Chr(BitAND($iFlag, 64) + 28) & "\|^\||\|\||\|$", "\\\\")) Then Return SetError(1, 0, "")
	Local $IndexSubKey[101] = [100], $SubKeyName, $BS = "\", $sKeyList, $I = 1, $sKeyFlag = BitAND($iFlag, 1), $sKeyFilter = StringReplace($sFilter, "*", "")
	If BitAND($iFlag, 2) Then $sKeyList = @LF & $KeyName
	If Not BitAND($iFlag, 64) Then $sFilter = StringRegExpReplace(BitAND($iFlag, 16) & "(?i)(", "16\(\?\i\)|\d+", "") & StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace($sFilter, "[^*?|]+", "\\Q$0\\E"), "\\E(?=\||$)", "$0\$"), "(?<=^|\|)\\Q", "^$0"), "\*+", ".*") & ")"
	While $I
		$IndexSubKey[$I] += 1
		$SubKeyName = RegEnumKey($KeyName, $IndexSubKey[$I])
		If @error Then
			$IndexSubKey[$I] = 0
			$I -= 1
			$KeyName = StringLeft($KeyName, StringInStr($KeyName, "\", 1, -1) - 1)
			ContinueLoop
		EndIf
		If $sKeyFilter Then
			If StringRegExp($SubKeyName, $sFilter) Then $sKeyList &= @LF & $KeyName & $BS & $SubKeyName
		Else
			$sKeyList &= @LF & $KeyName & $BS & $SubKeyName
		EndIf
		If $sKeyFlag Then ContinueLoop
		$I += 1
		If $I > $IndexSubKey[0] Then
			$IndexSubKey[0] += 100
			ReDim $IndexSubKey[$IndexSubKey[0] + 1]
		EndIf
		$KeyName &= $BS & $SubKeyName
	WEnd
	If Not $sKeyList Then Return SetError(2, 0, "")
	If BitAND($iFlag, 128) <> 128 Then Return StringSplit(StringTrimLeft($sKeyList, 1), @LF, StringReplace(BitAND($iFlag, 32), "32", 2))
	$sKeyList = _RegEnumValEx(StringSplit(StringTrimLeft($sKeyList, 1), @LF), $iFlag, $vFilter, $iValueTypes)
	Return SetError(@Error, 0, $sKeyList)
EndFunc

Func _RegEnumValEx($aKeyList, $iFlag = 0, $sFilter = "*", $iValueTypes = 0)
	If StringRegExp($sFilter, "\v") Then Return SetError(3, 0, "")
	If Not IsArray($aKeyList) Then $aKeyList = StringSplit($aKeyList, @LF)
	Local $aKeyValList[1954][4], $iKeyVal = Int(BitAND($iFlag, 32) = 0), $sKeyVal = 1953, $sRegEnumVal, $iRegEnumVal, $RegRead = BitAND($iFlag, 256), $vFilter = StringReplace($sFilter, "*", "")
	Dim $sValueTypes
	If Not BitAND($iFlag, 64) Then $sFilter = StringRegExpReplace(BitAND($iFlag, 16) & "(?i)(", "16\(\?\i\)|\d+", "") & StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace($sFilter, "[^*?|]+", "\\Q$0\\E"), "\\E(?=\||$)", "$0\$"), "(?<=^|\|)\\Q", "^$0"), "\*+", ".*") & ")"
	For $i = 1 To $aKeyList[0]
		$iRegEnumVal = 0
		While 1
			If $iKeyVal = $sKeyVal Then
				If $sKeyVal = 3999744 Then ExitLoop
				$sKeyVal *= 2
				ReDim $aKeyValList[$sKeyVal + 1][4]
			EndIf
			$aKeyValList[$iKeyVal][0] = $aKeyList[$i]
			$iRegEnumVal += 1
			$sRegEnumVal = RegEnumVal($aKeyList[$i], $iRegEnumVal)
			If @Error <> 0 Then
				If $iRegEnumVal = 1 And $vFilter = "" Then $iKeyVal += 1
				ExitLoop
			EndIf
			$aKeyValList[$iKeyVal][2] = $sValueTypes[@Extended]
			If BitAND(@Extended, $iValueTypes) <> $iValueTypes Then ContinueLoop
			If $vFilter And Not StringRegExp($sRegEnumVal, $sFilter) Then ContinueLoop
			$aKeyValList[$iKeyVal][1] = $sRegEnumVal
			If $RegRead Then $aKeyValList[$iKeyVal][3] = RegRead($aKeyList[$i], $sRegEnumVal)
			$iKeyVal += 1
		WEnd
	Next
	$sRegEnumVal = $iKeyVal - Int(BitAND($iFlag, 32) = 0)
	If Not $sRegEnumVal Or ($sRegEnumVal = 1 And $vFilter = "" And $aKeyValList[$iKeyVal - $sRegEnumVal][2] = "") Then Return SetError(4, 0, "")
	ReDim $aKeyValList[$iKeyVal][4]
	If Not BitAND($iFlag, 32) Then $aKeyValList[0][0] = $iKeyVal - 1
	Return $aKeyValList
EndFunc

Func _nice_COMerrorHandler($i = 0)
	If $i == 1 Then
		Dim $_nice_COMerrorArray[301][9]
		$_nice_COMerrorArray[0][0] = 0
		$_nice_COMerrorObj = ObjEvent("AutoIt.Error", "_nice_COMerrorHandler")
		Return
	EndIf
	If $i == 2 Then
		If Not @Compiled Then
			Local $n = 0, $c = 0, $s = FileRead(@ScriptFullPath)
			Local $a = StringSplit($s, @CRLF, 1)
			For $n = 1 To $_nice_COMerrorArray[0][0]
				If Int($_nice_COMerrorArray[$n][7]) > $a[0] Then ContinueLoop
				$_nice_COMerrorArray[$n][8] = StringStripWS($a[Int($_nice_COMerrorArray[$n][7])], 3)
			Next
			If StringInStr($s, "; only for the ANSI compiled version" & @CRLF) Then
				For $n = 1 To $a[0]
					If StringInStr($a[$n], "; only for the ANSI compiled version") Then $c += 1
					If $n > 50 Then ExitLoop
				Next
				For $n = 1 To $_nice_COMerrorArray[0][0]
					$_nice_COMerrorArray[$n][7] = $_nice_COMerrorArray[$n][7] - $c
				Next
			EndIf
		EndIf
		$_nice_COMerrorArray[1][0] = ""
		ReDim $_nice_COMerrorArray[$_nice_COMerrorArray[0][0] + 1][9]
		;_ArrayDisplay($_nice_COMerrorArray, "ScriptOMatic - COM Errors intercepted ( the script will continue after this screen )")
		Return
	EndIf
	If $_nice_COMerrorArray[0][0] = 300 Then
		$_nice_COMerrorArray[0][8] = "ScriptLine: only first 300 errors shown !!!"
		Return
	EndIf
	If StringInStr($_nice_COMerrorArray[1][0], "|" & $_nice_COMerrorObj.scriptline & "|") Then Return
	$i = $_nice_COMerrorArray[0][0] + 1
	$_nice_COMerrorArray[0][0] = $i
	$_nice_COMerrorArray[$i][1] = "0x" & Hex($_nice_COMerrorObj, 8)
	$_nice_COMerrorArray[$i][2] = $_nice_COMerrorObj.windescription
	$_nice_COMerrorArray[$i][3] = $_nice_COMerrorObj.source
	$_nice_COMerrorArray[$i][4] = $_nice_COMerrorObj.helpfile
	$_nice_COMerrorArray[$i][5] = $_nice_COMerrorObj.helpcontext
	$_nice_COMerrorArray[$i][6] = $_nice_COMerrorObj.lastdllerror
	$_nice_COMerrorArray[$i][7] = $_nice_COMerrorObj.scriptline
	$_nice_COMerrorArray[1][0] = $_nice_COMerrorArray[1][0] & "|" & $_nice_COMerrorObj.scriptline & "|"
	If $i == 1 Then
		$_nice_COMerrorArray[0][1] = "ErrorNumber:"
		$_nice_COMerrorArray[0][2] = "WinDescription:"
		$_nice_COMerrorArray[0][3] = "Source:"
		$_nice_COMerrorArray[0][4] = "HelpFile:"
		$_nice_COMerrorArray[0][5] = "HelpContext:"
		$_nice_COMerrorArray[0][6] = "LastDLLerror:"
		$_nice_COMerrorArray[0][7] = "ScriptLineNumber:"
		$_nice_COMerrorArray[0][8] = "ScriptLine:"
	EndIf
EndFunc

Func _SvcisRunning($SRVNAME)
	Local $HADVAPI32
	Local $ARRET
	Local $HSC
	Local $HSERVICE
	Local $BRUNNING = 0
	$HADVAPI32 = DllOpen("advapi32.dll")
	If $HADVAPI32 = -1 Then Return 0
	$ARRET = DllCall($HADVAPI32, "long", "OpenSCManager", "str", ".", "str", "ServicesActive", "long", $SC_MANAGER_CONNECT)
	If $ARRET[0] <> 0 Then
		$HSC = $ARRET[0]
		$ARRET = DllCall($HADVAPI32, "long", "OpenService", "long", $HSC, "str", $SRVNAME, "long", $SERVICE_INTERROGATE)
		If $ARRET[0] <> 0 Then
			$HSERVICE = $ARRET[0]
			$ARRET = DllCall($HADVAPI32, "int", "ControlService", "long", $HSERVICE, "long", $SERVICE_CONTROL_INTERROGATE, "str", "")
			$BRUNNING = $ARRET[0]
			DllCall($HADVAPI32, "int", "CloseServiceHandle", "long", $HSERVICE)
		EndIf
		DllCall($HADVAPI32, "int", "CloseServiceHandle", "long", $HSC)
	EndIf
	DllClose($HADVAPI32)
	Return $BRUNNING
EndFunc

Func _SvcGetName($sService)
	For $objService In ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2").ExecQuery("SELECT * FROM Win32_Service")
		If $objService.DisplayName = $sService Then
			Return $objService.Name
		EndIf
	Next
	Return False
EndFunc

Func _SvcSetStartMode($sService, $sMode)
	If StringLower($sMode) == "demand" Then
		$sMode = "Manual"
	ElseIf StringLower($sMode) == "auto" Then
		$sMode = "Automatic"
	ElseIf StringLower($sMode) == "disabled" Then
		$sMode = "Disabled"
	EndIf
	If Not($sMode=="Automatic" Or $sMode=="Manual" Or $sMode=="Disabled" Or $sMode=="Boot" Or $sMode=="System") Then
		Return False
	EndIf
	For $objService In ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2").ExecQuery("SELECT * FROM Win32_Service")
		If $objService.Name == $sService Then
			If $objService.StartMode == $sMode Then
			EndIf
			Local $iOutput = $objService.ChangeStartMode($sMode)
			Return ($iOutput==0)
		EndIf
	Next
	Return False
EndFunc

Func _SvcGetStartMode($sService)
	For $objService In ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2").ExecQuery("SELECT * FROM Win32_Service")
		If StringLower($objService.Name) == StringLower($sService) Then
			Return $objService.StartMode
		EndIf
	Next
	Return False
EndFunc

Func _SvcStart($sService, $bForce = True)
	For $objService In ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2").ExecQuery("SELECT * FROM Win32_Service")
		If $objService.Name = $sService Then
			Local $iOutput = $objService.StartService()
			If $iOutput==0 Or $iOutput==10 Then
				Return True
			EndIf
			If $iOutput == 14 And $bForce==True Then
				$objService.ChangeStartMode("Manual")
				$iOutput = $objService.StartService()
				If $iOutput==0 Or $iOutput==10 Then
					Return True
				EndIf
			EndIf
			Return False
		EndIf
	Next
	Return False
EndFunc

Func _SvcStop($sService)
	For $objService In ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2").ExecQuery("SELECT * FROM Win32_Service")
		If $objService.Name = $sService Then
			Local $iOutput = $objService.StopService()
			If $iOutput==0 Or $iOutput==6 Then
				Return True
			EndIf
			Return False
		EndIf
	Next
	Return False
EndFunc

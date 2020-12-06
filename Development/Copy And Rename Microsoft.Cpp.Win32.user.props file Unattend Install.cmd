ren %localappdata%\Microsoft\MSBuild\v4.0\Microsoft.Cpp.Win32.user.props BACKUP_Microsoft.Cpp.Win32.user.props
ren %localappdata%\Microsoft\MSBuild\v4.0\Standard_Microsoft.Cpp.x64.user.props BACKUP_Standard_Microsoft.Cpp.x64.user

xcopy \\SERVER\Software\Installations\Programmers\Microsoft.Cpp.Win32.user.props %localappdata%\Microsoft\MSBuild\v4.0\
xcopy \\SERVER\Software\Installations\Programmers\Microsoft.Cpp.x64.user.props %localappdata%\Microsoft\MSBuild\v4.0\
xcopy D:\PropertyPages\Standard_Microsoft.Cpp.Win32.user.props %APPDATA%\..\Local\Microsoft\MSBuild\Microsoft.Cpp.Win32.user.props
xcopy D:\PropertyPages\Standard_Microsoft.Cpp.x64.user.props %APPDATA%\..\Local\Microsoft\MSBuild\Microsoft.Cpp.x64.user.props
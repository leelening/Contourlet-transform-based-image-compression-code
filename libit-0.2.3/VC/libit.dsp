# Microsoft Developer Studio Project File - Name="libit" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=libit - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libit.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libit.mak" CFG="libit - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libit - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "libit - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "libit - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBIT_EXPORTS" /YX /FD /c
# ADD CPP /nologo /MT /W3 /GX /O2 /I "../include" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBIT_EXPORTS" /FR /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x40c /d "NDEBUG"
# ADD RSC /l 0x40c /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 1
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBIT_EXPORTS" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /I "../include" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBIT_EXPORTS" /YX /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x40c /d "_DEBUG"
# ADD RSC /l 0x40c /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "libit - Win32 Release"
# Name "libit - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\arithmetic_codec.c
# End Source File
# Begin Source File

SOURCE=..\src\channel.c
# End Source File
# Begin Source File

SOURCE=..\src\convcode.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\cplx.c
# End Source File
# Begin Source File

SOURCE=..\src\distance.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\filter.c
# End Source File
# Begin Source File

SOURCE=..\src\fourier.c
# End Source File
# Begin Source File

SOURCE=..\src\hmmalgo.c
# End Source File
# Begin Source File

SOURCE=..\src\io.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\mat.c
# End Source File
# Begin Source File

SOURCE=..\src\math.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\parser.c
# End Source File
# Begin Source File

SOURCE=..\src\poly.c
# End Source File
# Begin Source File

SOURCE=..\src\quantizer.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\random.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\separable2D.c
# End Source File
# Begin Source File

SOURCE=..\src\source.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\source_fit.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\source_func.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\vec.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\vlc.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\vlc_coding.c

!IF  "$(CFG)" == "libit - Win32 Release"

!ELSEIF  "$(CFG)" == "libit - Win32 Debug"

# ADD CPP /I "../include/"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\wavelet.c
# End Source File
# Begin Source File

SOURCE=..\src\wavelet2D.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\include\it\channel.h
# End Source File
# Begin Source File

SOURCE=..\include\it\convcode.h
# End Source File
# Begin Source File

SOURCE=..\include\it\cplx.h
# End Source File
# Begin Source File

SOURCE=..\include\it\distance.h
# End Source File
# Begin Source File

SOURCE=..\include\it\filter.h
# End Source File
# Begin Source File

SOURCE=..\include\it\fourier.h
# End Source File
# Begin Source File

SOURCE=..\include\it\io.h
# End Source File
# Begin Source File

SOURCE=..\include\it\mat.h
# End Source File
# Begin Source File

SOURCE=..\include\it\math.h
# End Source File
# Begin Source File

SOURCE=..\include\it\parser.h
# End Source File
# Begin Source File

SOURCE=..\include\it\poly.h
# End Source File
# Begin Source File

SOURCE=..\include\it\quantizer.h
# End Source File
# Begin Source File

SOURCE=..\include\it\random.h
# End Source File
# Begin Source File

SOURCE=..\include\it\separable2D.h
# End Source File
# Begin Source File

SOURCE=..\include\it\source.h
# End Source File
# Begin Source File

SOURCE=..\include\it\source_fit.h
# End Source File
# Begin Source File

SOURCE=..\include\it\source_func.h
# End Source File
# Begin Source File

SOURCE=..\include\it\transform.h
# End Source File
# Begin Source File

SOURCE=..\include\it\transform2D.h
# End Source File
# Begin Source File

SOURCE=..\include\it\types.h
# End Source File
# Begin Source File

SOURCE=..\include\it\vec.h
# End Source File
# Begin Source File

SOURCE=..\include\it\vlc.h
# End Source File
# Begin Source File

SOURCE=..\include\it\vlc_coding.h
# End Source File
# Begin Source File

SOURCE=..\include\it\wavelet.h
# End Source File
# Begin Source File

SOURCE=..\include\it\wavelet2D.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project

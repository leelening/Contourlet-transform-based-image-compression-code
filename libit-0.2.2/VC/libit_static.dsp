# Microsoft Developer Studio Project File - Name="libit_static" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=libit_static - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libit_static.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libit_static.mak" CFG="libit_static - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libit_static - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "libit_static - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "libit_static - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "libit_static\Release"
# PROP Intermediate_Dir "libit_static\Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /I "../include" /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD BASE RSC /l 0x40c /d "NDEBUG"
# ADD RSC /l 0x40c /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "libit_static - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "libit_static___Win32_Debug"
# PROP BASE Intermediate_Dir "libit_static___Win32_Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "libit_static\Debug"
# PROP Intermediate_Dir "libit_static\Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /W3 /Gm /GX /ZI /Od /I "../include" /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD BASE RSC /l 0x40c /d "_DEBUG"
# ADD RSC /l 0x40c /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ENDIF 

# Begin Target

# Name "libit_static - Win32 Release"
# Name "libit_static - Win32 Debug"
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
# End Source File
# Begin Source File

SOURCE=..\src\cplx.c
# End Source File
# Begin Source File

SOURCE=..\src\distance.c
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
# End Source File
# Begin Source File

SOURCE=..\src\mat.c
# End Source File
# Begin Source File

SOURCE=..\src\math.c
# End Source File
# Begin Source File

SOURCE=..\src\parser.c
# End Source File
# Begin Source File

SOURCE=..\src\poly.c
# End Source File
# Begin Source File

SOURCE=..\src\quantizer.c
# End Source File
# Begin Source File

SOURCE=..\src\random.c
# End Source File
# Begin Source File

SOURCE=..\src\separable2D.c
# End Source File
# Begin Source File

SOURCE=..\src\source.c
# End Source File
# Begin Source File

SOURCE=..\src\source_fit.c
# End Source File
# Begin Source File

SOURCE=..\src\source_func.c
# End Source File
# Begin Source File

SOURCE=..\src\vec.c
# End Source File
# Begin Source File

SOURCE=..\src\vlc.c
# End Source File
# Begin Source File

SOURCE=..\src\vlc_coding.c
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

SOURCE=..\include\it\arithmetic_codec.h
# End Source File
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

SOURCE=..\include\it\fourier.h
# End Source File
# Begin Source File

SOURCE=..\include\it\hmmalgo.h
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
# End Target
# End Project

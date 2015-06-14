# Microsoft Developer Studio Project File - Name="ContourTst" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=ContourTst - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "ContourTst.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ContourTst.mak" CFG="ContourTst - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ContourTst - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ContourTst - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "ContourTst - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /I "D:\ProgramDir\VCProgramDir\ContourTst\include" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x804 /d "NDEBUG"
# ADD RSC /l 0x804 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 libit_static.lib cv.lib highgui.lib cxcore.lib cvcam.lib ml.lib cvaux.lib cvhaartraining.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib cxcore.lib cv.lib ml.lib cvaux.lib highgui.lib /nologo /subsystem:console /machine:I386 /libpath:"D:\ProgramDir\VCProgramDir\ContourTst\lib"

!ELSEIF  "$(CFG)" == "ContourTst - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /W3 /Gm /GX /ZI /Od /I "D:\ProgramDir\VCProgramDir\ContourTst\include" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x804 /d "_DEBUG"
# ADD RSC /l 0x804 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 libit_static.lib cv.lib highgui.lib cxcore.lib cvcam.lib ml.lib cvaux.lib cvhaartraining.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib cxcore.lib cv.lib ml.lib cvaux.lib highgui.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /libpath:"D:\ProgramDir\VCProgramDir\ContourTst\lib"
# SUBTRACT LINK32 /pdb:none

!ENDIF 

# Begin Target

# Name "ContourTst - Win32 Release"
# Name "ContourTst - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\libezbc\arithmetic_codec.cpp
# End Source File
# Begin Source File

SOURCE=.\libezbc\bitbuffer.cpp
# End Source File
# Begin Source File

SOURCE=.\contourlet.cpp
# End Source File
# Begin Source File

SOURCE=.\dfb.cpp
# End Source File
# Begin Source File

SOURCE=.\ezbc.cpp
# End Source File
# Begin Source File

SOURCE=.\libezbc\ezbc_codec.cpp
# End Source File
# Begin Source File

SOURCE=.\libezbc\ezbc_decoder.cpp
# End Source File
# Begin Source File

SOURCE=.\libezbc\ezbc_encoder.cpp
# End Source File
# Begin Source File

SOURCE=.\libezbc\ezbc_tables.cpp
# End Source File
# Begin Source File

SOURCE=.\main.cpp
# End Source File
# Begin Source File

SOURCE=.\pyramid.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\libezbc\arithmetic_codec.h
# End Source File
# Begin Source File

SOURCE=.\libezbc\bitbuffer.h
# End Source File
# Begin Source File

SOURCE=.\contourlet.h
# End Source File
# Begin Source File

SOURCE=.\dfb.h
# End Source File
# Begin Source File

SOURCE=.\ezbc.h
# End Source File
# Begin Source File

SOURCE=.\libezbc\ezbc_codec.h
# End Source File
# Begin Source File

SOURCE=.\libezbc\ezbc_decoder.h
# End Source File
# Begin Source File

SOURCE=.\libezbc\ezbc_encoder.h
# End Source File
# Begin Source File

SOURCE=.\libezbc\ezbc_tables.h
# End Source File
# Begin Source File

SOURCE=.\libezbc\ezbc_types.h
# End Source File
# Begin Source File

SOURCE=.\pyramid.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project

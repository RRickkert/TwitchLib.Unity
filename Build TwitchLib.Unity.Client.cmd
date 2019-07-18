@echo off

SET UnityProjectOutDir=TwitchLib.Client.Unity\TwitchLib.Client.Unity\bin\Release\netstandard2.0
SET OutDir=TwitchLib.Client.Unity\Builds

SET TwitchLibClientFolder=%UnityProjectOutDir%\TwitchLib.Client
SET TwitchLibClientUnityFolder=%UnityProjectOutDir%\TwitchLib.Client.Unity
SET TwitchLibCommunicationFolder=%UnityProjectOutDir%\TwitchLib.Communication

SET TwitchLibUnityCommonFolder=%UnityProjectOutDir%\TwitchLib.Unity.Common
SET LoggingFolder=%UnityProjectOutDir%\Logging

SET StandaloneFolder=%OutDir%\Standalone
SET SeparatedFolder=%OutDir%\Separated
if not exist %StandaloneFolder% mkdir %StandaloneFolder%
if not exist %SeparatedFolder% mkdir %SeparatedFolder%

SET StandaloneOutputFilePath=%StandaloneFolder%\TwitchLib.Client.Unity.Standalone
SET SeparatedOutputFilePath=%SeparatedFolder%\TwitchLib.Client.Unity

TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%StandaloneOutputFilePath%.dll %TwitchLibClientFolder%\*.dll %TwitchLibClientUnityFolder%\*.dll %TwitchLibCommunicationFolder%\*.dll %TwitchLibUnityCommonFolder%\*.dll %LoggingFolder%\*.dll
TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%SeparatedOutputFilePath%.dll %TwitchLibClientFolder%\*.dll %TwitchLibClientUnityFolder%\*.dll /lib:%TwitchLibCommunicationFolder% /lib:%TwitchLibUnityCommonFolder% /lib:%LoggingFolder%

del %StandaloneOutputFilePath%.pdb
del %SeparatedOutputFilePath%.pdb

xcopy /y %TwitchLibCommunicationFolder% %SeparatedFolder%
xcopy /y %TwitchLibUnityCommonFolder% %SeparatedFolder%
xcopy /y %LoggingFolder% %SeparatedFolder%

if ["%~1"]==["-nopause"] (Goto :eof)

pause
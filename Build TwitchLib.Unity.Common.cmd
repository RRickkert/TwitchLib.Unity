::@echo off

SET UnityProjectOutDir=TwitchLib.Unity.Common\TwitchLib.Unity.Common\bin\Release\netstandard2.0
SET OutDir=TwitchLib.Unity.Common\Builds

SET TwitchLibUnitySharedFolder=%UnityProjectOutDir%

SET StandaloneFolder=%OutDir%\Standalone
SET SeparatedFolder=%OutDir%\Separated
if not exist %StandaloneFolder% mkdir %StandaloneFolder%
if not exist %SeparatedFolder% mkdir %SeparatedFolder%

SET StandaloneOutputFilePath=%StandaloneFolder%\TwitchLib.Unity.Common.Standalone
SET SeparatedOutputFilePath=%SeparatedFolder%\TwitchLib.Unity.Common

TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%StandaloneOutputFilePath%.dll %TwitchLibUnitySharedFolder%\*.dll
TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%SeparatedOutputFilePath%.dll %TwitchLibUnitySharedFolder%\*.dll

del %StandaloneOutputFilePath%.pdb
del %SeparatedOutputFilePath%.pdb

if ["%~1"]==["-nopause"] (Goto :eof)

pause
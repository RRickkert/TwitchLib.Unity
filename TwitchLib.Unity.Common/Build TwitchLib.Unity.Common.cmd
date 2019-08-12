@echo off
Pushd "%~dp0"
echo -------- [STARTING] Building TwitchLib.Unity.Common DLLs.. --------

SET UnityProjectOutDir=TwitchLib.Unity.Common\bin\Release\netstandard2.0
SET OutDir=Builds

SET TwitchLibUnitySharedFolder=%UnityProjectOutDir%

SET StandaloneFolder=%OutDir%\Standalone
SET SeparatedFolder=%OutDir%\Separated
if not exist %StandaloneFolder% mkdir %StandaloneFolder%
if not exist %SeparatedFolder% mkdir %SeparatedFolder%

SET StandaloneOutputFilePath=%StandaloneFolder%\TwitchLib.Unity.Common.Standalone
SET SeparatedOutputFilePath=%SeparatedFolder%\TwitchLib.Unity.Common

..\TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%StandaloneOutputFilePath%.dll %TwitchLibUnitySharedFolder%\*.dll
..\TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%SeparatedOutputFilePath%.dll %TwitchLibUnitySharedFolder%\*.dll

del %StandaloneOutputFilePath%.pdb
del %SeparatedOutputFilePath%.pdb

popd

echo -------- [COMPLETED] Built TwitchLib.Unity.Common DLLs! --------

if ["%~1"]==["-nopause"] (Goto :eof)

pause
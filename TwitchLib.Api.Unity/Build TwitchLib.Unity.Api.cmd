@echo off
Pushd "%~dp0"
echo -------- [STARTING] Building TwitchLib.Api.Unity DLLs.. --------

SET UnityProjectOutDir=TwitchLib.Api.Unity\bin\Release\netstandard2.0
SET OutDir=Builds

SET TwitchLibApiFolder=%UnityProjectOutDir%\TwitchLib.Api
SET TwitchLibApiUnityFolder=%UnityProjectOutDir%\TwitchLib.Api.Unity

SET TwitchLibUnityCommonFolder=%UnityProjectOutDir%\TwitchLib.Unity.Common
SET LoggingFolder=%UnityProjectOutDir%\Logging
SET JsonFolder=%UnityProjectOutDir%\Json

SET StandaloneFolder=%OutDir%\Standalone
SET SeparatedFolder=%OutDir%\Separated
if not exist %StandaloneFolder% mkdir %StandaloneFolder%
if not exist %SeparatedFolder% mkdir %SeparatedFolder%

SET StandaloneOutputFilePath=%StandaloneFolder%\TwitchLib.Api.Unity.Standalone
SET SeparatedOutputFilePath=%SeparatedFolder%\TwitchLib.Api.Unity

..\TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%StandaloneOutputFilePath%.dll %TwitchLibApiFolder%\*.dll %TwitchLibApiUnityFolder%\*.dll %TwitchLibUnityCommonFolder%\*.dll %LoggingFolder%\*.dll %JsonFolder%\*.dll
..\TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%SeparatedOutputFilePath%.dll %TwitchLibApiFolder%\*.dll %TwitchLibApiUnityFolder%\*.dll /lib:%TwitchLibUnityCommonFolder% /lib:%LoggingFolder% /lib:%JsonFolder%

del %StandaloneOutputFilePath%.pdb
del %SeparatedOutputFilePath%.pdb

xcopy /y /q %TwitchLibUnityCommonFolder% %SeparatedFolder%>NUL
xcopy /y /q %LoggingFolder% %SeparatedFolder%>NUL
xcopy /y /q %JsonFolder% %SeparatedFolder%>NUL

popd

echo -------- [COMPLETED] Built TwitchLib.Api.Unity DLLs! --------

if ["%~1"]==["-nopause"] (Goto :eof)

pause
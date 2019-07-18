@echo off

SET UnityProjectOutDir=TwitchLib.Api.Unity\TwitchLib.Api.Unity\bin\Release\netstandard2.0
SET OutDir=TwitchLib.Api.Unity\Builds

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

TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%StandaloneOutputFilePath%.dll %TwitchLibApiFolder%\*.dll %TwitchLibApiUnityFolder%\*.dll %TwitchLibUnityCommonFolder%\*.dll %LoggingFolder%\*.dll %JsonFolder%\*.dll
TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%SeparatedOutputFilePath%.dll %TwitchLibApiFolder%\*.dll %TwitchLibApiUnityFolder%\*.dll /lib:%TwitchLibUnityCommonFolder% /lib:%LoggingFolder% /lib:%JsonFolder%

del %StandaloneOutputFilePath%.pdb
del %SeparatedOutputFilePath%.pdb

xcopy /y %TwitchLibUnityCommonFolder% %SeparatedFolder%
xcopy /y %LoggingFolder% %SeparatedFolder%
xcopy /y %JsonFolder% %SeparatedFolder%

if ["%~1"]==["-nopause"] (Goto :eof)

pause
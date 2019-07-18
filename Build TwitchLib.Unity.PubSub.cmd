@echo off

SET UnityProjectOutDir=TwitchLib.PubSub.Unity\TwitchLib.PubSub.Unity\bin\Release\netstandard2.0
SET OutDir=TwitchLib.PubSub.Unity\Builds

SET TwitchLibPubSubFolder=%UnityProjectOutDir%\TwitchLib.PubSub
SET TwitchLibPubSubUnityFolder=%UnityProjectOutDir%\TwitchLib.PubSub.Unity

SET TwitchLibCommunicationFolder=%UnityProjectOutDir%\TwitchLib.Communication
SET TwitchLibUnityCommonFolder=%UnityProjectOutDir%\TwitchLib.Unity.Common
SET LoggingFolder=%UnityProjectOutDir%\Logging
SET JsonFolder=%UnityProjectOutDir%\Json

SET StandaloneFolder=%OutDir%\Standalone
SET SeparatedFolder=%OutDir%\Separated
if not exist %StandaloneFolder% mkdir %StandaloneFolder%
if not exist %SeparatedFolder% mkdir %SeparatedFolder%

SET StandaloneOutputFilePath=%StandaloneFolder%\TwitchLib.PubSub.Unity.Standalone
SET SeparatedOutputFilePath=%SeparatedFolder%\TwitchLib.PubSub.Unity

TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%StandaloneOutputFilePath%.dll %TwitchLibPubSubFolder%\*.dll %TwitchLibPubSubUnityFolder%\*.dll %TwitchLibCommunicationFolder%\*.dll %TwitchLibUnityCommonFolder%\*.dll %LoggingFolder%\*.dll %JsonFolder%\*.dll
TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%SeparatedOutputFilePath%.dll %TwitchLibPubSubFolder%\*.dll %TwitchLibPubSubUnityFolder%\*.dll /lib:%TwitchLibCommunicationFolder% /lib:%TwitchLibUnityCommonFolder% /lib:%LoggingFolder% /lib:%JsonFolder%

del %StandaloneOutputFilePath%.pdb
del %SeparatedOutputFilePath%.pdb

xcopy /y %TwitchLibCommunicationFolder% %SeparatedFolder%
xcopy /y %TwitchLibUnityCommonFolder% %SeparatedFolder%
xcopy /y %LoggingFolder% %SeparatedFolder%

if ["%~1"]==["-nopause"] (Goto :eof)

pause
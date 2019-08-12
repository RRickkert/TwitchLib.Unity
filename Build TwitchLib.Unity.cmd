@echo off
::call "TwitchLib.Unity.Common/Build TwitchLib.Unity.Common.cmd" -nopause
::echo.
::call "TwitchLib.Client.Unity/Build TwitchLib.Unity.Client.cmd" -nopause
::echo.
::call "TwitchLib.Api.Unity/Build TwitchLib.Unity.Api.cmd" -nopause
::echo.
::call "TwitchLib.PubSub.Unity/Build TwitchLib.Unity.PubSub.cmd" -nopause
::echo.

echo -------- [STARTING] Building TwitchLib.Unity.. --------

SET OutDir=Builds

SET TwitchLibUnityApiSeparatedFolder=TwitchLib.Api.Unity\Builds\Separated
SET TwitchLibUnityClientSeparatedFolder=TwitchLib.Client.Unity\Builds\Separated
SET TwitchLibUnityPubSubSeparatedFolder=TwitchLib.PubSub.Unity\Builds\Separated
SET TwitchLibUnitySharedSeparatedFolder=TwitchLib.Unity.Common\Builds\Separated

SET StandaloneFolder=%OutDir%\Standalone
SET SeparatedFolder=%OutDir%\Separated
if not exist %StandaloneFolder% mkdir %StandaloneFolder%
if not exist %SeparatedFolder% mkdir %SeparatedFolder%

xcopy /y /q %TwitchLibUnityApiSeparatedFolder% %SeparatedFolder%
xcopy /y /q %TwitchLibUnityClientSeparatedFolder% %SeparatedFolder%
xcopy /y /q %TwitchLibUnityPubSubSeparatedFolder% %SeparatedFolder%
xcopy /y /q %TwitchLibUnitySharedSeparatedFolder% %SeparatedFolder%

TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%StandaloneFolder%\TwitchLib.Unity.dll %SeparatedFolder%\*.dll

echo -------- [COMPLETED] Built TwitchLib.Unity! --------
echo.

pause
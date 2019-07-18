call "Build TwitchLib.Unity.Common.cmd" -nopause
call "Build TwitchLib.Unity.Client.cmd" -nopause
call "Build TwitchLib.Unity.Api.cmd" -nopause
call "Build TwitchLib.Unity.PubSub.cmd" -nopause

SET OutDir=Builds

SET TwitchLibUnityApiSeparatedFolder=TwitchLib.Api.Unity\Builds\Separated
SET TwitchLibUnityClientSeparatedFolder=TwitchLib.Client.Unity\Builds\Separated
SET TwitchLibUnityPubSubSeparatedFolder=TwitchLib.PubSub.Unity\Builds\Separated
SET TwitchLibUnitySharedSeparatedFolder=TwitchLib.Unity.Common\Builds\Separated

SET StandaloneFolder=%OutDir%\Standalone
SET SeparatedFolder=%OutDir%\Separated
if not exist %StandaloneFolder% mkdir %StandaloneFolder%
if not exist %SeparatedFolder% mkdir %SeparatedFolder%

xcopy /y %TwitchLibUnityApiSeparatedFolder% %SeparatedFolder%
xcopy /y %TwitchLibUnityClientSeparatedFolder% %SeparatedFolder%
xcopy /y %TwitchLibUnityPubSubSeparatedFolder% %SeparatedFolder%
xcopy /y %TwitchLibUnitySharedSeparatedFolder% %SeparatedFolder%

TwitchLib.Unity.Common\Assemblies\ILMerge.exe /wildcards /out:%StandaloneFolder%\TwitchLib.Unity.dll %SeparatedFolder%\*.dll

pause
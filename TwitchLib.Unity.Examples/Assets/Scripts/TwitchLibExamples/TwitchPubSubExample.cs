﻿namespace TwitchLibExamples
{
    // If type or namespace TwitchLib could not be found. Make sure you add the latest TwitchLib.Unity.dll to your project folder
    // Download it here: https://github.com/TwitchLib/TwitchLib.Unity/releases
    // Or download the repository at https://github.com/TwitchLib/TwitchLib.Unity, build it, and copy the TwitchLib.Unity.dll from the output directory
    using TwitchLib.Unity;
	using UnityEngine;

	public class TwitchPubSubExample : MonoBehaviour
	{
		private PubSub _pubSub;

		private void Start()
		{
			// To keep the Unity application active in the background, you can enable "Run In Background" in the player settings:
			// Unity Editor --> Edit --> Project Settings --> Player --> Resolution and Presentation --> Resolution --> Run In Background
			// This option seems to be enabled by default in more recent versions of Unity. An aditional, less recommended option is to set it in code:
			// Application.runInBackground = true;

			// Create new instance of PubSub Client
			_pubSub = new PubSub();

			// Subscribe to Events
			_pubSub.OnBitsReceived += OnBitsReceived;
			_pubSub.OnPubSubServiceConnected += OnPubSubServiceConnected;

			// Connect
			_pubSub.Connect();
		}

		private void OnPubSubServiceConnected(object sender, System.EventArgs e)
		{
			Debug.Log("PubSubServiceConnected!");

			// On connect listen to Bits evadsent
			// Please note that to listen to the bits event requires the bits:read scope in the OAuth token.
			_pubSub.ListenToBitsEvents(Secrets.USERNAME_FROM_OAUTH_TOKEN);

			// SendTopics accepts an oauth optionally, which is necessary for some topics, such as bit events.
			_pubSub.SendTopics(Secrets.OAUTH_TOKEN);
		}

		private void OnBitsReceived(object sender, TwitchLib.PubSub.Events.OnBitsReceivedArgs e)
		{
			// Do your bits logic here.
		}
	}
}

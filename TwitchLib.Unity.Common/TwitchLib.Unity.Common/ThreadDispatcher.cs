using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;

namespace TwitchLib.Unity
{
    public class ThreadDispatcher : MonoBehaviour
    {
        private static ThreadDispatcher _instance;

        private static readonly ConcurrentQueue<Action> _executionQueue = new ConcurrentQueue<Action>();

        /// <summary>
        /// Ensures a thread dispatcher is created if there is none.
        /// </summary>
        public static void EnsureCreated([CallerMemberName] string callerMemberName = null)
        {
            if (_instance == null || _instance.gameObject == null)
                _instance = CreateThreadDispatcherSingleton(callerMemberName);
        }

        /// <summary>
        /// Locks the queue and adds the Action to the queue
        /// </summary>
        /// <param name="action">function that will be executed from the main thread.</param>
        public static void Enqueue(Action action)
        {
            if (action == null)
            {
                Debug.LogError("Attempting to enqueue null as action");
                Debug.LogWarning(new Exception().StackTrace);
                return;
            }
            _executionQueue.Enqueue(action);
        }

        private void Update()
        {
            if (_executionQueue == null)
            {
                Debug.LogWarning("_executionQueue == null");
                return;
            }
            //storing the count here instead of locking the queue so we don't end up with a deadlock when one of the actions queues another action
            int count = _executionQueue.Count;
            for (int i = 0; i < count; i++)
            {
                Action action;
                if (!_executionQueue.TryDequeue(out action))
                {
                    Debug.LogWarning($"Failed to dequeue event.");
                    continue;
                }
                action.Invoke();
            }
            
        }

        private static ThreadDispatcher CreateThreadDispatcherSingleton(string callerMemberName)
        {
            if (!UnityThread.CurrentIsMainThread)
                Debug.LogException(new InvalidOperationException($"The {callerMemberName} can only be created from the main thread. Did you accidentally delete the " + nameof(ThreadDispatcher) + " in your scene?"));

            ThreadDispatcher threadDispatcher = new GameObject(nameof(ThreadDispatcher)).AddComponent<ThreadDispatcher>();
            DontDestroyOnLoad(threadDispatcher);
            return threadDispatcher;
        }
    }
}

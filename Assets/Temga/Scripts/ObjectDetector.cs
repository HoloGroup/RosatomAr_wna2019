using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

[RequireComponent(typeof(ARTrackedObjectManager))]
public class ObjectDetector : MonoBehaviour
{
    [SerializeField] private GameObject _onTrackedPrefab;
    private ARTrackedObjectManager _tom;

    // Start is called before the first frame update
    void Start()
    {
        _tom = GetComponent<ARTrackedObjectManager>();
        _tom.trackedObjectsChanged += _tom_trackedObjectsChanged;
    }

    private void _tom_trackedObjectsChanged(ARTrackedObjectsChangedEventArgs obj)
    {
        if (obj.added[0].trackingState == UnityEngine.XR.ARSubsystems.TrackingState.Tracking && SceneManager.Instance.gameState == GameState.Searching)
        {
            SceneManager.Instance.SetGameState(GameState.Intro);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    [ContextMenu("ManualTrack")]
    private void ManualTrack()
    {
        if (SceneManager.Instance.gameState == GameState.Searching)
        {
            Instantiate(_onTrackedPrefab, Vector3.zero, Quaternion.identity);
            SceneManager.Instance.SetGameState(GameState.Intro);
        }
    }
}

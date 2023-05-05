using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActiveOutDoor : MonoBehaviour
{

    public GameObject _outDoor;
    public GameObject[] _outDoorFlyingObjects;
    public GameObject _inDoor;
    public GameObject _inDoorPins;

    // Start is called before the first frame update
    void Awake()
    {
        SceneManager.Instance.Xray += Instance_Xray;
        SceneManager.Instance.Base += Instance_Base;
        SceneManager.Instance.OnOffed += Instance_OnOffed;
    }

    private void Instance_OnOffed()
    {
        if(_inDoor.activeSelf)
        {
            _inDoorPins.SetActive(!_inDoorPins.activeSelf);
        }
        else
        {
            _outDoor.SetActive(!_outDoor.activeSelf);
        }
    }

    private void Instance_Base()
    {
        _outDoor.SetActive(true);
        foreach(var obj in _outDoorFlyingObjects)
        {
            var renderers = obj.GetComponentsInChildren<Renderer>(true);
            foreach(var renderer in renderers)
            {
                renderer.enabled = true;
            }
        }
        _inDoor.SetActive(false);
    }

    private void Instance_Xray()
    {
        _outDoor.SetActive(false);
        foreach (var obj in _outDoorFlyingObjects)
        {
            var renderers = obj.GetComponentsInChildren<Renderer>(true);
            foreach (var renderer in renderers)
            {
                renderer.enabled = false;
            }
        }

        _inDoor.SetActive(true);
        _inDoorPins.SetActive(true);
    }



    // Update is called once per frame
    void Update()
    {
        
    }
}

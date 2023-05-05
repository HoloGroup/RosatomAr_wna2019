using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HandleModalWindow : MonoBehaviour
{
    public GameObject[] _modalWindows;

    private int _last_model = 0;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void OpenModalWindow(int i)
    {
        _modalWindows[i].SetActive(true);
        _last_model = i;
        SceneManager.Instance.SetGameState(GameState.ModelWindow);
    }

    public void ResetModal()
    {
        _modalWindows[_last_model].SetActive(false);
    }

}

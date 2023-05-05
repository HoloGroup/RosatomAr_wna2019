using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ChangeSprite : MonoBehaviour
{

    public Sprite Ru;
    public Sprite Eng;

    private Button _btn;

    // Start is called before the first frame update
    void Start()
    {
        _btn = GetComponent<Button>();
        SceneManager.Instance.LngChanged += Instance_LngChanged;
    }

    private void Instance_LngChanged(SceneManager.lang lng)
    {
        Debug.Log(lng);
        switch(lng)
        {
            case SceneManager.lang.Eng:
                GetComponent<Image>().sprite = Eng;
                break;
            case SceneManager.lang.Ru:
                GetComponent<Image>().sprite = Ru;
                break;
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}

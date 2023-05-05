using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GetValues : MonoBehaviour
{

    public TranfromObjects _to;
    public Dropdown dropdown;

    // Start is called before the first frame update
    void Start()
    {
        dropdown = GetComponent<Dropdown>();
        foreach (var o in _to.objects)
        {
            dropdown.options.Add(new Dropdown.OptionData(o.name));
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}

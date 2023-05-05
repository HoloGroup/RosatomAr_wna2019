using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class S_PropellerRot : MonoBehaviour
{
    public float speed = 5.0f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {

        transform.Rotate(0, Time.deltaTime * speed, 0);
    }
}

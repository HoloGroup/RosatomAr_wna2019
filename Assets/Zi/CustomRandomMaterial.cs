using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CustomRandomMaterial : MonoBehaviour
{

    public Material[] mats;
    // Start is called before the first frame update
    void Start()
    {
        GetComponent<MeshRenderer>().materials[1] = mats[Random.Range(0, mats.Length)];
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}

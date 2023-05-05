using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Script_TrafficLight : MonoBehaviour
{

    private int counter = 0;
    public float redLightTime = 1.0f;
    public float yellowLightTime = 0.2f;
    public float greenLightTime = 1.0f;
    private float waitTime;
    public GameObject ColliderObject;
    public GameObject trafficLightObject;
    public bool flipStartingSignal;
    private MeshCollider meshcollider;
    Renderer rend;


    //private float currentAngle = 0.0f;
    //private int currentSignal;

    // Start is called before the first frame update
    void Start()
    {
        if (ColliderObject != null && trafficLightObject != null)
        {
            Debug.Log("pedikj");
            rend = trafficLightObject.GetComponent<Renderer>();
            if (flipStartingSignal)
            {
                counter = counter + 2;
            }
            meshcollider = ColliderObject.GetComponent<MeshCollider>();


            StartCoroutine("NewSignal");
        }

    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator NewSignal()
    {
        while (true)
        {
            //currentAngle = (Mathf.PI) * counter / 2;
            //currentSignal = Mathf.RoundToInt(Mathf.Sin(currentAngle));
            //current signal goes 1 for red, 0 for yellow and -1 for green

            if ((counter % 4) == 0)
            {
                rend.material.SetFloat("_Red", 1.0f);
                rend.material.SetFloat("_Green", 0.0f);
                rend.material.SetFloat("_Blue", 0.0f);
                waitTime = redLightTime;
            }
            if ((counter % 4) == 1 | (counter % 4) == 3)
            {
                rend.material.SetFloat("_Red", 0.0f);
                rend.material.SetFloat("_Green", 1.0f);
                rend.material.SetFloat("_Blue", 0.0f);
                waitTime = yellowLightTime;
                meshcollider.enabled = true;

            }
            if ((counter % 4) == 2)
            {
                rend.material.SetFloat("_Red", 0.0f);
                rend.material.SetFloat("_Green", 0.0f);
                rend.material.SetFloat("_Blue", 1.0f);
                waitTime = greenLightTime;
                meshcollider.enabled = false;
            }
            counter = counter + 1;
            yield return new WaitForSeconds(waitTime);
        }
    }
}

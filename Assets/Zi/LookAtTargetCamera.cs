using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LookAtTargetCamera : MonoBehaviour
{
    Script_HoverCar hc;
    Camera mainCamera;
    public float farCamera = 0.3f;
    void Start()
    {
        mainCamera = Camera.main;
        Debug.Log(mainCamera);
        hc = this.GetComponent<Script_HoverCar>();
    }

    // Update is called once per frame
    void Update()
    {
        if (mainCamera != null)
        {
            if (Vector3.Distance(mainCamera.transform.position, this.transform.position) < farCamera)
            {
                hc.enabled = false;
                Vector3 relativePos = mainCamera.transform.position - transform.position;
                Quaternion rotation = Quaternion.LookRotation(relativePos, Vector3.up);
                transform.rotation = Quaternion.Slerp(transform.rotation, rotation, Time.deltaTime);
            }
            else
            {
                hc.enabled = true;
            }
        }
    }
}

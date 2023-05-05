using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using PathCreation;

public class Script_HoverCar : MonoBehaviour
{
    public PathCreator pathCreator;
    public float startPos;
    public float speedMax = 5.0f;
    public float acceleration = 5.0f;
    public float rayTraceLength = 10.0f;
    public EndOfPathInstruction endOfPathInstuction;
    float speed;
    private int layerMask;
    float len;
    public bool bDoRayCast = false;

    void Start()
    {
        layerMask = 1 << 9;
        if (!bDoRayCast)
        {
            speed = speedMax;
        }

    }

    // Update is called once per frame
    void Update()
    {
        if (bDoRayCast)
        {
            RaycastHit hit;
            if (Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, rayTraceLength, layerMask))
            {
                Debug.DrawRay(transform.position, transform.TransformDirection(Vector3.forward) * hit.distance, Color.yellow);
                speed = speed - acceleration * Time.deltaTime;

            }
            else
            {
                Debug.DrawRay(transform.position, transform.TransformDirection(Vector3.forward) * rayTraceLength, Color.white);
                speed = speed + acceleration * Time.deltaTime;
            }
            speed = Mathf.Clamp(speed, 0.0f, speedMax);
        }
        len = len + speed * Time.deltaTime;
        transform.position = pathCreator.path.GetPointAtDistance(len + startPos, endOfPathInstuction);
        transform.rotation = pathCreator.path.GetRotationAtDistance(len + startPos, endOfPathInstuction);
    }
}

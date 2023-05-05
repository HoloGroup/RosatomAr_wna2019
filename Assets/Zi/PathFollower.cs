using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using PathCreation;

public class PathFollower : MonoBehaviour
{
    public PathCreator pathCreator;
    public float startPos;
    public float speed = 5.0f;
    public float acceleration = 5.0f;
    public float rayTraceLength = 10.0f;
    private float lenChange;
    float len = 0;

    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        RaycastHit hit;
        if (Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, 1000))
        {
            Debug.DrawRay(transform.position, transform.TransformDirection(Vector3.forward) * hit.distance, Color.yellow);
            lenChange = speed - acceleration * Time.deltaTime;
            
        }
        else
        {
            Debug.DrawRay(transform.position, transform.TransformDirection(Vector3.forward) * 1000, Color.white);
            lenChange = speed + acceleration * Time.deltaTime;
        }

        lenChange = Mathf.Clamp(lenChange, 0.0f, speed);


        len = len + lenChange;
        if (pathCreator != null)
        {
            transform.position = pathCreator.path.GetPointAtDistance(len + startPos);
            transform.rotation = pathCreator.path.GetRotationAtDistance(len + startPos);
        }

    }
}

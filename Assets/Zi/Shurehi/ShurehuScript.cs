using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShurehuScript : MonoBehaviour
{
    public float startTime = 2.0f;
    public float speed = 2.0f;
    public float frequency;
    public float amplitude;
    void Start()
    {
        
    }
    void Update()
    {
        StartCoroutine("Wait");
    }
    IEnumerator Wait()
    {
        yield return new WaitForSeconds(startTime);
        transform.Rotate(0, Time.deltaTime * speed, 0);
        transform.position = new Vector3(this.transform.position.x, Mathf.Sin(Time.time * frequency) * amplitude, this.transform.position.z);

    }
}

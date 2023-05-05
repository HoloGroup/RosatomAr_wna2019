using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeStateMaterial : MonoBehaviour
{
    float speed;
    void Start()
    {
        StartCoroutine(ChangeSpeed(0, 1, 2f));
    }
    void Update()
    {
    }

    IEnumerator ChangeSpeed(float v_start, float v_end, float duration)
    {
        float elapsed = 0.0f;
        while (elapsed < duration)
        {
            GetComponent<Renderer>().material.SetFloat("_changeState", Mathf.Lerp(v_start, v_end, elapsed / duration));
            elapsed += Time.deltaTime;
            yield return null;
        }
        speed = v_end;
    }
}

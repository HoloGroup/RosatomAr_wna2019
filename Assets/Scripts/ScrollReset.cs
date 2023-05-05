using UnityEngine;
using System.Collections;

public class ScrollReset : MonoBehaviour {


    void OnDisable()
    {
        Vector3 defaultPos = transform.localPosition;
        defaultPos.y = 0.0f;
        transform.localPosition = defaultPos;
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class S_TextureOffset : MonoBehaviour
{
    // Start is called before the first frame update
    public float offsetX = -4.8f;
    public float offsetY = 0.0f;
    public float animationSpeedMin = 0.8f;
    public float animationSpeedMax = 1.2f;
    Renderer rend;
    Animator animatorComponent;



    void Start()
    {
        rend = GetComponent<Renderer>();
        animatorComponent = GetComponent<Animator>();
        float CycleOffsetRnd = Random.Range(0.0f, 1.0f);
        float SpeedRnd = Random.Range(animationSpeedMin, animationSpeedMax);
        animatorComponent.SetFloat("CycleOffset", CycleOffsetRnd);
        animatorComponent.SetFloat("Speed", SpeedRnd);
    }

    // Update is called once per frame
    void Update()
    {
   
        rend.material.SetTextureOffset("_MainTex", new Vector2(offsetX, offsetY));

    }
}

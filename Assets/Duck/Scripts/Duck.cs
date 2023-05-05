using UnityEngine;
using System.Collections;

public class Duck : MonoBehaviour {
    public Animator duck;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        if (Input.GetKey(KeyCode.Alpha1))
        {
            duck.SetBool("idle", true);
            duck.SetBool("walk", false);
            duck.SetBool("eat", false);
        }
        if (Input.GetKey(KeyCode.Alpha2))
        {
            duck.SetBool("walk", true);
            duck.SetBool("idle", false);
            duck.SetBool("rise", false);
            duck.SetBool("eat", false);
        }
        if (Input.GetKey(KeyCode.Alpha3))
        {
            duck.SetBool("eat", true);
            duck.SetBool("walk", false);
        }
        if (Input.GetKey(KeyCode.Alpha4))
        {
            duck.SetBool("lay", true);
            duck.SetBool("eat", false);
            duck.SetBool("swim", false);
            duck.SetBool("rise", false);
        }
        if (Input.GetKey(KeyCode.Alpha5))
        {
            duck.SetBool("swim", true);
            duck.SetBool("lay", false);
        }
        if (Input.GetKey(KeyCode.Alpha6))
        {
            duck.SetBool("rise", true);
            duck.SetBool("swim", false);
            duck.SetBool("lay", false);
        }
    }
}

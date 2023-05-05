using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerCamera : MonoBehaviour
{
    // Start is called before the first frame update
    Camera mainCamera;
    bool isClicked = false;
    public GameObject plashka;
    public float cameraFar = 0.3f;
    void Start()
    {
        mainCamera = Camera.main;
        mainCamera.enabled = true;
        Debug.Log(mainCamera);
        isClicked = false;
    }

    // Update is called once per frame
    void Update()
    {
        //if (mainCamera != null)
        //{
        //    if ((Vector3.Distance(mainCamera.transform.position, this.transform.position) < cameraFar) && !isNear)
        //    {
        //        Debug.Log("Near to plashka");
        //        isNear = true;
        //        if (plashka != null)
        //        {
        //            Animator animator = plashka.GetComponent<Animator>();
        //            animator.SetBool("open", isNear);
        //        }
        //    }
        //    if ((Vector3.Distance(mainCamera.transform.position, this.transform.position) > cameraFar) && isNear)
        //    {
        //        Debug.Log("Far to plashka");
        //        isNear = false;
        //        Animator animator = plashka.GetComponent<Animator>();
        //        animator.SetBool("open", isNear);
        //    }
        //}
    }

    public void OpenCloseInfo()
    {
        Animator animator = plashka.GetComponent<Animator>();
        if (isClicked == false)
        {
            isClicked = true;
        }else
        {
            isClicked = false;
        }
        animator.SetBool("open", isClicked);
    }

}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TranfromObjects : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject[] objects;
    public int currentObj;

    public float step = 0.01f;
    public float degreesPerTap = 5;
    void Start()
    {
        foreach(var o in objects)
        {
            GetTransform(o.transform);
        }
    }

    // Update is called once per frame
    void Update()
    {  
    }

    public void MoveLeft()
    {
        objects[currentObj].transform.position += new Vector3(-step, 0, 0);
    }

    public void MoveRight()
    {
        objects[currentObj].transform.position += new Vector3(step, 0, 0);
    }

    public void MoveDown()
    {
        objects[currentObj].transform.position += new Vector3(0, -step, 0);
    }

    public void MoveUp()
    {
        objects[currentObj].transform.position += new Vector3(0, step, 0);
    }

    public void MoveForward()
    {
        objects[currentObj].transform.position += new Vector3(0, 0, step);
    }

    public void MoveBacwards()
    {
        objects[currentObj].transform.position += new Vector3(0, 0, -step);
    }

    public void RotateLeft()
    {
        objects[currentObj].transform.Rotate(Vector3.up, -degreesPerTap, Space.World);
    }

    public void RotateRight()
    {
        objects[currentObj].transform.Rotate(Vector3.up, degreesPerTap, Space.World);
    }

    public void SetCurrentObject(int obj)
    {
        currentObj = obj;
    }

    public void SaveAll()
    {
        foreach (var o in objects)
        {
            Save(o.transform);
        }
    }

    private void Save(Transform t)
    {
        PlayerPrefs.SetFloat(t.name + "Xcoord", t.localPosition.x);
        PlayerPrefs.SetFloat(t.name + "Ycoord", t.localPosition.y);
        PlayerPrefs.SetFloat(t.name + "Zcoord", t.localPosition.z);

        PlayerPrefs.SetFloat(t.name + "Xrotation", t.localRotation.x);
        PlayerPrefs.SetFloat(t.name + "Yrotation", t.localRotation.y);
        PlayerPrefs.SetFloat(t.name + "Zrotation", t.localRotation.z);
        PlayerPrefs.SetFloat(t.name + "Wrotation", t.localRotation.w);
    }

    private void GetTransform(Transform t)
    {
        var x = PlayerPrefs.HasKey(t.name + "Xcoord") ? PlayerPrefs.GetFloat(t.name + "Xcoord") : t.localPosition.x;
        var y = PlayerPrefs.HasKey(t.name + "Ycoord") ? PlayerPrefs.GetFloat(t.name + "Ycoord") : t.localPosition.y;
        var z = PlayerPrefs.HasKey(t.name + "Zcoord") ? PlayerPrefs.GetFloat(t.name + "Zcoord") : t.localPosition.z;
        Vector3 posVec = new Vector3(x, y, z);
        t.localPosition = posVec;

        var xrotation = PlayerPrefs.HasKey(t.name + "Xrotation") ? PlayerPrefs.GetFloat(t.name + "Xrotation") : t.localRotation.x;
        var yrotation = PlayerPrefs.HasKey(t.name + "Yrotation") ? PlayerPrefs.GetFloat(t.name + "Yrotation") : t.localRotation.y;
        var zrotation = PlayerPrefs.HasKey(t.name + "Zrotation") ? PlayerPrefs.GetFloat(t.name + "Zrotation") : t.localRotation.z;
        var wrotation = PlayerPrefs.HasKey(t.name + "Wrotation") ? PlayerPrefs.GetFloat(t.name + "Wrotation") : t.localRotation.z;

        var rotation = new Quaternion(xrotation, yrotation, zrotation, wrotation);

        if (t.GetComponentInParent<ActiveOutDoor>() != null && t.GetComponent<LookAtFixed>() != null)
        {
            var eulerRotation = rotation.eulerAngles;
            eulerRotation.x = 30;
            eulerRotation.z = 0;
            var fixedRotation = new Quaternion();
            fixedRotation.eulerAngles = eulerRotation;
            t.localRotation = fixedRotation;
        }
        else
            t.localRotation = rotation;
    }
}

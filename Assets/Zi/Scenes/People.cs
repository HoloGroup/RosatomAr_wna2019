using System.Collections;
using System.Collections.Generic;
using PathCreation;
using UnityEngine;

public class People : MonoBehaviour
{
    public PathCreator currentPath;
    public EndOfPathInstruction endOfPathInstruction;
    public GameObject[] peoples;
    public int numberOfCopy = 1;
    public int positionMin = 8;
    public int positionMax = 20;
    public GameObject ParentGO;
    private GameObject tempGO;
    PathFollower pf;

    // Start is called before the first frame update
    void Start()
    {
        for (int i = 0; i < peoples.Length; i++)
        {
            //Instantiate(peoples[i], currentPath.path.GetPoint(0), Quaternion.identity);
            Instantiate(peoples[i], ParentGO.transform, false);
            peoples[i].GetComponent<PathFollower>().pathCreator = currentPath;
            peoples[i].GetComponent<PathFollower>().speed = 0.05f;
            peoples[i].GetComponent<PathFollower>().acceleration = 0.5f;
            peoples[i].GetComponent<Animator>().playbackTime = Random.value;
            peoples[i].GetComponent<PathFollower>().startPos = i * Random.Range(positionMin, positionMax);
            //peoples[0].GetComponent<Animator>().SetTrigger("Walk");
            peoples[i].transform.localScale = new Vector3(0.01f, 0.01f, 0.01f);
        }
    }

    // Update is called once per frame
    void Update()
    {
    }
}

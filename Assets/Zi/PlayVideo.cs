using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Video;

public class PlayVideo : MonoBehaviour
{
    // Start is called before the first frame update
    float timer;
    public float startTime = 4.0f;
    public GameObject Shurehi1;
    private VideoPlayer _vp;
    private PlayableDirector _tmlCntrl;

    void Start()
    {
        StartCoroutine("Wait");
        _vp = GetComponent<VideoPlayer>();
        _tmlCntrl = GetComponent<PlayableDirector>();
    }

    // Update is called once per frame
    void Update()
    {
    }
    IEnumerator Wait()
    {
        while (true)
        {
            _vp.Stop();
            _vp.Play();
            _tmlCntrl.Play();
            yield return new WaitForSeconds(startTime);
        }
    }
}

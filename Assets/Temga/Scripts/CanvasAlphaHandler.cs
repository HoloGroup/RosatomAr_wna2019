using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;
using RenderHeads.Media.AVProVideo;


[RequireComponent(typeof(CanvasGroup))]
public class CanvasAlphaHandler : MonoBehaviour
{
    public MediaPlayer mediaPlayer;
    public bool AutoClose = false;

    private CanvasGroup _cg;
    private float _currentTime = 0;

    void Awake()
    {
        _cg = GetComponent<CanvasGroup>();
    }

    private void Update()
    {
        if(AutoClose)
        {
            if(_cg.alpha == 1)
            {
                if (_currentTime > 10)
                {
                    _cg.alpha = 0;
                    _cg.interactable = false;
                    _cg.blocksRaycasts = false;
                    _currentTime = 0;
                }
                else
                {
                    _currentTime += Time.deltaTime;
                }
            }
        }
    }

    public void FadeOut()
    {

        _cg.DOFade(0,0.3f).OnComplete(() => {
            _cg.interactable = false;
            _cg.blocksRaycasts = false;
            if (mediaPlayer != null) mediaPlayer.Stop(); 
        });
        _currentTime = 0;
    }


    public void FadeIn()
    {
        if(mediaPlayer != null) mediaPlayer.Play();
        _cg.DOFade(1, 0.3f).OnComplete(() => {
            _cg.interactable = true;
            _cg.blocksRaycasts = true;
        });
        _currentTime = 0;
    }
}

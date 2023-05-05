using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class LanguageToggle : MonoBehaviour {

    public delegate void LanguageSwitch();
    public static event LanguageSwitch OnLanguageChanged;

    public static bool isRussian = true;

    public Sprite russianFlag;
    public Sprite englishFlag;

    public Image currentImage;

    private void Awake()
    {
        isRussian = true;
        //currentImage = GetComponent<Image>();
    }

    public void Switch()
    {
        isRussian = !isRussian;
        currentImage.overrideSprite = isRussian ? englishFlag : russianFlag;
        if (OnLanguageChanged != null)
            OnLanguageChanged();
    }
}

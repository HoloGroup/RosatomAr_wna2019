using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class MultiLangImage : MonoBehaviour {

	public Sprite rusImg;
	public Sprite engImg;

	private Image currentimg;

	private void Start()
	{
		LanguageToggle.OnLanguageChanged += HandleLanguageChange;
	}
	
	private void OnEnable()
	{
		currentimg = GetComponent<Image>();
		currentimg.overrideSprite = LanguageToggle.isRussian ? rusImg : engImg;
	}

	private void OnDisable()
	{
		currentimg = GetComponent<Image>();
		currentimg.overrideSprite = LanguageToggle.isRussian ? rusImg : engImg;
	}

	private void HandleLanguageChange()
	{
		currentimg.overrideSprite = LanguageToggle.isRussian ? rusImg : engImg;
	}
}

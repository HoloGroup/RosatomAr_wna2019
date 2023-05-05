using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class MultiLangToggleTexture : MonoBehaviour {

	public Sprite engTexture;
	public Sprite rusTexture;

	private Image img;

	private void Start()
	{
		LanguageToggle.OnLanguageChanged += HandleLanguageChange;
	}

	private void OnEnable()
	{
		img = GetComponent<Image> ();
		img.overrideSprite = LanguageToggle.isRussian ? rusTexture : engTexture;
	}

	private void HandleLanguageChange()
	{
		img.overrideSprite = LanguageToggle.isRussian ? rusTexture : engTexture;
	}
}

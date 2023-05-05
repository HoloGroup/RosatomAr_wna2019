using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class MultiLangTextController : MonoBehaviour {

    [Multiline]
    [TextArea(3, 10)]
    public string russianText;
    [Space(20)]
    [Multiline]
    [TextArea(3, 10)]
    public string englishText;

    private Text currentTextField;

	private void Start()
    {
        LanguageToggle.OnLanguageChanged += HandleLanguageChange;
    }

    private void OnEnable()
    {
        currentTextField = GetComponent<Text>();
        currentTextField.text = LanguageToggle.isRussian ? russianText : englishText;
    }

    private void OnDisable()
    {
        currentTextField = GetComponent<Text>();
        currentTextField.text = LanguageToggle.isRussian ? russianText : englishText;
    }

    private void HandleLanguageChange()
    {
        currentTextField.text = LanguageToggle.isRussian ? russianText : englishText;
    }
}

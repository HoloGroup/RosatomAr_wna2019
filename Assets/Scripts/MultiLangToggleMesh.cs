using UnityEngine;
using System.Collections;

public class MultiLangToggleMesh : MonoBehaviour {

    [TextArea(3, 10)]
    [Multiline]
    public string russianText;
    [TextArea(3, 10)]
    [Multiline]
    public string englishText;

    private TextMesh currentTextField;

    private void Start()
    {
        LanguageToggle.OnLanguageChanged += HandleLanguageChange;
    }

    private void OnEnable()
    {
        currentTextField = GetComponent<TextMesh>();
        currentTextField.text = LanguageToggle.isRussian ? russianText : englishText;
    }

    private void HandleLanguageChange()
    {
        currentTextField.text = LanguageToggle.isRussian ? russianText : englishText;
    }
}

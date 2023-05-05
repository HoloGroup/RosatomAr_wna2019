using UnityEngine;

public enum GameState { NullState, Idle, Searching, Intro, Scene, Info, ModelWindow }
public delegate void OnStateChangeHandler();
public delegate void OnXRay();
public delegate void onBase();
public delegate void onOff();
public delegate void LangChange(SceneManager.lang lng);

public class SceneManager
{

    private static SceneManager _instance = null;
    public event OnStateChangeHandler OnStateChange;
    public GameState gameState { get; private set; } = GameState.NullState;
    public GameState priviousGameState { get; private set; } = GameState.NullState;
    public event OnXRay Xray;
    public event onBase Base;
    public event LangChange LngChanged;
    public event onOff OnOffed;

    public lang CurrentLang = lang.Eng;

    public enum lang
    {
        Ru,
        Eng
    }
    protected SceneManager() { }

    // Singleton pattern implementation
    public static SceneManager Instance
    {
        get
        {
            if (_instance == null)
            {
                _instance = new SceneManager();
            }
            return _instance;
        }
    }

    public void SetGameState(GameState gameState)
    {
        this.priviousGameState = this.gameState;
        this.gameState = gameState;
        if (OnStateChange != null)
        {
            OnStateChange();
        }
    }

    public void SetXray()
    {
        if (Xray != null)
        {
            Xray();
        }
    }

    public void SetBase()
    {
        if (Base != null)
        {
            Base();
        }
    }

    public void SetOnOffed()
    {
        if (OnOffed != null)
        {
            OnOffed();
        }
    }

    public void ChangeLang()
    {
        if (LngChanged != null)
        {
            CurrentLang = CurrentLang == lang.Eng ? lang.Ru : lang.Eng;
            LngChanged(CurrentLang);
        }
    }

}
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class SteteController : MonoBehaviour
{

    SceneManager SM;


    public StatesEvents[] statesEvents;

    public void SetState(string gameState)
    {
        SM.SetGameState((GameState)System.Enum.Parse(typeof(GameState), gameState));
    }

    private void Awake()
    {
        SM = SceneManager.Instance;
        SM.OnStateChange += HandleOnStateChange;

        Debug.Log("Current game state when Awakes: " + SM.gameState);

        SM.SetGameState(GameState.Idle);
    }

    private void HandleOnStateChange()
    {
        Debug.Log("Current game state: " + SM.gameState);
        Debug.Log("Current Privious state: " + SM.priviousGameState);
        statesEvents[(int)SM.priviousGameState].OnExit.Invoke();
        statesEvents[(int)SM.gameState].OnEnter.Invoke();
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void RestartAll()
    {
        Application.LoadLevel("Main");
    }

    [Serializable]
    public struct StatesEvents
    {
        public GameState gs;
        public UnityEvent OnEnter;
        public UnityEvent OnExit;
    }

    public void SetXray()
    {
        SceneManager.Instance.SetXray();
    }

    public void SetBase()
    {
        SceneManager.Instance.SetBase();
    }

    public void SetOnOffed()
    {
        SceneManager.Instance.SetOnOffed();
    }

    [ContextMenu("Change language")]
    public void ChangeLang()
    {
        SceneManager.Instance.ChangeLang();
    }

}

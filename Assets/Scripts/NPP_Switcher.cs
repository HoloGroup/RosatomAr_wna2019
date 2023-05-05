using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class NPP_Switcher : MonoBehaviour {
	//public AnimationClip Genplan_OFF;
//	public AnimationClip Genplan_ON;
	public Animator NPP_2016;
	public GameObject pins_Genplan;
	public GameObject pins_Reactor;
	public GameObject pins_Eblok;
	public GameObject cut;
	public bool pins = false;
	public bool pins_g = false;
	public bool pins_e = false;
	public bool pins_r = false;
	public int phaseNumber = 1;
	float pause = 1f;
	bool transit = false;
	public Transform player; // Drag your player here
	private Vector2 fp; // first finger position
	private Vector2 lp; // last finger position

    public Button[] btns;

    private bool windowActive;

	void Start () {
	}

    private void OnDisable()
    {
//        foreach(Button btn in btns)
//        {
//            btn.interactable = true;
//        }
//        btns[0].interactable = false;
//        phaseNumber = 1;
        transit = false;
		StopAllCoroutines();
//		State1Instant ();
    }

    public void WindowActive(bool active)
    {
        windowActive = active;
    }

	public void Pins () {
		pins = !pins;
		if(phaseNumber == 1){
			pins_Genplan.SetActive(pins);
			pins_g = true;
			pins_e = false;
			pins_r = false;
		}
		if(phaseNumber == 2){
			pins_Eblok.SetActive(pins);
			pins_e = true;
			pins_g = false;
			pins_r = false;
		}
		if(phaseNumber == 3){
			pins_Reactor.SetActive(pins);
			pins_r = true;
			pins_g = false;
			pins_e = false;
		}
		if(phaseNumber == 4){
			pins_Reactor.SetActive(pins);
			pins_r = true;
			pins_g = false;
			pins_e = false;
		}


	}

	public void st1()
	{
		if (transit == false)
		{
			StartCoroutine (State1 ());
            for (int i = 0; i < btns.Length; i++)
            {
                btns[i].interactable = true;
            }
            btns[0].interactable = false;
        }
	}
	public void st2()
	{
        if (transit == false)
		{
			StartCoroutine (State2 ());
            for (int i = 0; i < btns.Length; i++)
            {
                btns[i].interactable = true;
            }
            btns[1].interactable = false;
        }
	}
	public void st3()
	{
        if (transit == false)
		{
			StartCoroutine (State3 ());
            for (int i = 0; i < btns.Length; i++)
            {
                btns[i].interactable = true;
            }
            btns[2].interactable = false;
        }
	}
	public void st4()
	{
        if (transit == false)
		{
			StartCoroutine (State4 ());
            for (int i = 0; i < btns.Length; i++)
            {
                btns[i].interactable = true;
            }
            btns[3].interactable = false;
        }
	}

	private void State1Instant(){
		pins_r = false;
		pins_g = false;
		pins_e = false;
		pins_Genplan.SetActive (pins_g);
		pins_Eblok.SetActive (pins_e);
		pins_Reactor.SetActive (pins_r);
		if(phaseNumber != 1){
			if(phaseNumber == 2){
				phaseNumber = 1;
				NPP_2016.Play("Eblok_Zoom_Out");
				NPP_2016.Play("Genplan_ON");
			}
			if(phaseNumber == 3){
				phaseNumber = 1;
				NPP_2016.Play("Insides_OFF");
				if(Camera.main.transform.position.x > cut.transform.position.x){
					NPP_2016.Play("Eblok_Cut1_OFF");
				} else {
					NPP_2016.Play("Eblok_Cut2_OFF");
				}
				NPP_2016.Play("Eblok_Fade_In");
				NPP_2016.Play("Eblok_Zoom_Out");
				NPP_2016.Play("Genplan_ON");
			}

			if(phaseNumber == 4){
				phaseNumber = 1;
				NPP_2016.Play("Schematic_OFF");
				NPP_2016.Play("Insides_OFF");
				NPP_2016.Play("Eblok_Fade_In");
				NPP_2016.Play("Eblok_Zoom_Out");
				NPP_2016.Play("Genplan_ON");
			}
		}
		if (pins) {
			pins_g = true;
			pins_e = false;
			pins_r = false;
			pins_Genplan.SetActive (pins_g);
			pins_Eblok.SetActive (pins_e);
			pins_Reactor.SetActive (pins_r);

		}
	}

	public IEnumerator State1 (){
		transit = true;
		pins_r = false;
		pins_g = false;
		pins_e = false;
		pins_Genplan.SetActive (pins_g);
		pins_Eblok.SetActive (pins_e);
		pins_Reactor.SetActive (pins_r);
			if(phaseNumber != 1){
			if(phaseNumber == 2){
				phaseNumber = 1;
                NPP_2016.Play("Eblok_Zoom_Out");
				yield return new WaitForSeconds(pause/3);
                
                NPP_2016.Play("Genplan_ON");
			}
			if(phaseNumber == 3){
				phaseNumber = 1;
                NPP_2016.Play("Insides_OFF");
				if(Camera.main.transform.position.x > cut.transform.position.x){
					NPP_2016.Play("Eblok_Cut1_OFF");
				} else {
					NPP_2016.Play("Eblok_Cut2_OFF");
				}
				yield return new WaitForSeconds(pause/2);
                
                NPP_2016.Play("Eblok_Fade_In");
				yield return new WaitForSeconds(pause/3);
				NPP_2016.Play("Eblok_Zoom_Out");
				yield return new WaitForSeconds(pause/3);
				NPP_2016.Play("Genplan_ON");
			}

			if(phaseNumber == 4){
				phaseNumber = 1;
                NPP_2016.Play("Schematic_OFF");
				yield return new WaitForSeconds(pause/2);
                
                NPP_2016.Play("Insides_OFF");
				NPP_2016.Play("Eblok_Fade_In");
				yield return new WaitForSeconds(pause/2);
				NPP_2016.Play("Eblok_Zoom_Out");
				yield return new WaitForSeconds(pause/2);
				NPP_2016.Play("Genplan_ON");
			}
        }
		if (pins) {
			pins_g = true;
			pins_e = false;
			pins_r = false;
			pins_Genplan.SetActive (pins_g);
			pins_Eblok.SetActive (pins_e);
			pins_Reactor.SetActive (pins_r);

		}
		transit = false;
		StopAllCoroutines();
	}

	public IEnumerator State2 (){
		transit = true;
		pins_r = false;
		pins_g = false;
		pins_e = false;
		pins_Genplan.SetActive (pins_g);
		pins_Eblok.SetActive (pins_e);
		pins_Reactor.SetActive (pins_r);
		if(phaseNumber != 2){
			if(phaseNumber == 1){
			    phaseNumber = 2;
                NPP_2016.Play("Genplan_OFF");
			    yield return new WaitForSeconds(pause/3);
                
                NPP_2016.Play("Eblok_Zoom_In");
		    }
			if(phaseNumber == 3){
				phaseNumber = 2;
                if (Camera.main.transform.position.x > cut.transform.position.x){
					NPP_2016.Play("Eblok_Cut1_OFF");
				} else {
					NPP_2016.Play("Eblok_Cut2_OFF");
				}
				yield return new WaitForSeconds(pause/2);
                
                NPP_2016.Play("Eblok_Fade_In");
				NPP_2016.Play("Insides_OFF");
			}
			if(phaseNumber == 4){
				phaseNumber = 2;
                NPP_2016.Play("Eblok_Fade_In");
				NPP_2016.Play("Insides_OFF");
				yield return new WaitForSeconds(pause/2);
                
                NPP_2016.Play("Schematic_OFF");
			}
        }
		if (pins) {
			pins_e = true;
			pins_g = false;
			pins_r = false;
			pins_Genplan.SetActive (pins_g);
			pins_Eblok.SetActive (pins_e);
			pins_Reactor.SetActive (pins_r);
		}
		transit = false;
		StopAllCoroutines();
	}

	public IEnumerator State3 (){
		transit = true;
		pins_r = false;
		pins_g = false;
		pins_e = false;
		pins_Genplan.SetActive (pins_g);
		pins_Eblok.SetActive (pins_e);
		pins_Reactor.SetActive (pins_r);
        if (phaseNumber != 3){
			if(phaseNumber == 1){
                phaseNumber = 3;
                NPP_2016.Play("Genplan_OFF");
				yield return new WaitForSeconds(pause/3);
				NPP_2016.Play("Eblok_Zoom_In");
				yield return new WaitForSeconds(pause/3);
				NPP_2016.Play("Eblok_Fade_Out");
				yield return new WaitForSeconds(pause/2);
				if(Camera.main.transform.position.x > cut.transform.position.x){
						NPP_2016.Play("Eblok_Cut1_ON");
					} else {
						NPP_2016.Play("Eblok_Cut2_ON");
					}
				NPP_2016.Play("Insides_ON");
				yield return new WaitForSeconds(pause);
                

            }
			if(phaseNumber == 2){
                phaseNumber = 3;
                NPP_2016.Play("Eblok_Fade_Out");
				NPP_2016.Play("Insides_ON");
					yield return new WaitForSeconds(pause/2);
				if(Camera.main.transform.position.x > cut.transform.position.x){
						NPP_2016.Play("Eblok_Cut1_ON");
					} else {
						NPP_2016.Play("Eblok_Cut2_ON");
					}
				yield return new WaitForSeconds(pause);
                
            }
			if(phaseNumber == 4){
                phaseNumber = 3;
                NPP_2016.Play("Schematic_OFF");
				if(Camera.main.transform.position.x > cut.transform.position.x){
						NPP_2016.Play("Eblok_Cut1_ON");
					} else {
						NPP_2016.Play("Eblok_Cut2_ON");
					}
				yield return new WaitForSeconds(pause);
                
            }
        }
		if (pins) {
			pins_r = true;
			pins_g = false;
			pins_e = false;
			pins_Genplan.SetActive (pins_g);
			pins_Eblok.SetActive (pins_e);
			pins_Reactor.SetActive (pins_r);
		}
		transit = false;
		StopAllCoroutines();
	}

	public IEnumerator State4 (){
		transit = true;
		pins_r = false;
		pins_g = false;
		pins_e = false;
		pins_Genplan.SetActive (pins_g);
		pins_Eblok.SetActive (pins_e);
		pins_Reactor.SetActive (pins_r);
		if(phaseNumber != 4){
			if(phaseNumber == 1){
				phaseNumber = 4;
                NPP_2016.Play("Genplan_OFF");
				yield return new WaitForSeconds(pause/2);
                
                NPP_2016.Play("Eblok_Zoom_In");
				yield return new WaitForSeconds(pause/2);
				NPP_2016.Play("Eblok_Fade_Out");
				NPP_2016.Play("Insides_ON");
				yield return new WaitForSeconds(pause/3);
				NPP_2016.Play("Schematic_ON");
			}
			if(phaseNumber == 2){
				phaseNumber = 4;
                NPP_2016.Play("Eblok_Fade_Out");
				NPP_2016.Play("Insides_ON");
				yield return new WaitForSeconds(pause/3);
                
                NPP_2016.Play("Schematic_ON");
			}
			if(phaseNumber == 3){
				phaseNumber = 4;
                if (Camera.main.transform.position.x > cut.transform.position.x){
						NPP_2016.Play("Eblok_Cut1_OFF");
					} else {
						NPP_2016.Play("Eblok_Cut2_OFF");
					}
				NPP_2016.Play("Schematic_ON");
				NPP_2016.Play("Rotor");
                yield return null;
                
            }
        }
		if (pins) {
			pins_r = true;
			pins_g = false;
			pins_e = false;
			pins_Genplan.SetActive (pins_g);
			pins_Eblok.SetActive (pins_e);
			pins_Reactor.SetActive (pins_r);
		}
		transit = false;
		StopAllCoroutines();
	}

	void Update () {
		if(phaseNumber == 3){
			if (transit == false) {
				if (Camera.main.transform.position.x > cut.transform.position.x) {
					NPP_2016.Play ("Eblok_Cut1_ON");
					NPP_2016.Play ("Eblok_Cut2_OFF");
				} else {
					NPP_2016.Play ("Eblok_Cut2_ON");
					NPP_2016.Play ("Eblok_Cut1_OFF");
				}
			}
		}
        if (!windowActive)
        {
            foreach (Touch touch in Input.touches)
            {
                if (touch.phase == TouchPhase.Began)
                {
                    fp = touch.position;
                    lp = touch.position;
                }
                if (touch.phase == TouchPhase.Moved)
                {
                    lp = touch.position;
                }
                if (touch.phase == TouchPhase.Ended)
                {
                    if ((fp.x - lp.x) > 80) // left swipe
                    {
                        if (phaseNumber == 1)
                        {
                            st2();
                        }
                        if (phaseNumber == 2)
                        {
                            st3();
                        }
                        if (phaseNumber == 3)
                        {
                            st4();
                        }
                    }
                    else if ((fp.x - lp.x) < -80) // right swipe
                    {
                        if (phaseNumber == 2)
                        {
                            st1();
                        }
                        if (phaseNumber == 3)
                        {
                            st2();
                        }
                        if (phaseNumber == 4)
                        {
                            st3();
                        }
                    }
                }
            }
        }
	}

}





		


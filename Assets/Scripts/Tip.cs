using UnityEngine;
using System.Collections;

public class Tip : MonoBehaviour {
	public Transform target;

	private float damping = 5;
	void Start () {
		target = Camera.main.transform;
	}
	// Update is called once per frame
	void Update () {
//		transform.rotation = Quaternion.LookRotation(target.position);

//		Vector3 vecTo = new Vector3(target.eulerAngles.x + 180, target.eulerAngles.y + 180, -target.eulerAngles.z);
		Quaternion to = target.rotation * Quaternion.Euler(0,180,0);
//		Quaternion to Quaternion.LookAtTarget(
		transform.rotation = Quaternion.Slerp(transform.rotation, to, Time.deltaTime * damping);
//
//		transform.rotation = Quaternion.LookRotation(target.position - transform.position);
	}
}

using UnityEngine;
using System.Collections;

	[AddComponentMenu("Camera-Control/Mouse Look")]
	public class Fly : MonoBehaviour {
		
		
		
		/// MouseLook rotates the transform based on the mouse delta.
		/// Minimum and Maximum values can be used to constrain the possible rotation
		
		/// To make an FPS style character:
		/// - Create a capsule.
		/// - Add the MouseLook script to the capsule.
		///   -> Set the mouse look to use LookX. (You want to only turn character but not tilt it)
		/// - Add FPSInputController script to the capsule
		///   -> A CharacterMotor and a CharacterController component will be automatically added.
		
		/// - Create a camera. Make the camera a child of the capsule. Reset it's transform.
		/// - Add a MouseLook script to the camera.
		///   -> Set the mouse look to use LookY. (You want the camera to tilt up and down like a head. The character already turns.)
		
		
		public enum RotationAxes { MouseXAndY = 0, MouseX = 1, MouseY = 2 }
		public RotationAxes axes = RotationAxes.MouseXAndY;
		public float sensitivityX = 5F;
		public float sensitivityY = 5F;
		
		public float minimumX = -360F;
		public float maximumX = 360F;
		
		public float minimumY = -22F;
		public float maximumY = 60F;
		
		public float damping = 1f;
		
		float rotationY = 0F;
//		private bool Android = false; 
//		private bool Ios = false; 
//		private bool PC = false; 
		public float smooth = 0.3F;
		public float distance = 5.0F;
//		private float yVelocity = 0.0F;
		private Quaternion localRotation; // 
		public float speed = 1.0f; // ajustable speed from Inspector in Unity editor
		public float movementSpeed = 10;
	void Start ()
	{}
		void Update ()
		{
	//	if(Input.GetKey("w") == true)
	//	{
	//		transform.position += transform.forward * Time.deltaTime * movementSpeed;
	//		movementSpeed += 0.2f;
	//	} else {
	//		movementSpeed = 10f;
	//	}
		Vector3 dir = new Vector3(); //(0,0,0)
//		float CharacterSpeed = 10.0f;
		
		if (Input.GetKey(KeyCode.W) || Input.GetKey(KeyCode.UpArrow))
		{
			dir.z += 1.0f;
			movementSpeed += 0.2f;
		}
		if (Input.GetKey(KeyCode.A) || Input.GetKey(KeyCode.LeftArrow))
		{
			dir.x -= 1.0f;
			movementSpeed += 0.2f;
		}
		if (Input.GetKey(KeyCode.S) || Input.GetKey(KeyCode.DownArrow))
		{
			dir.z -= 1.0f;
			movementSpeed += 0.2f;
		}
		if (Input.GetKey(KeyCode.D) || Input.GetKey(KeyCode.RightArrow))
		{
			dir.x += 1.0f;
			movementSpeed += 0.2f;
		}
		if (Input.GetKey(KeyCode.Space))
		{
			dir.y += 1.0f;
			movementSpeed += 0.2f;
		}
		if (Input.GetKey(KeyCode.LeftControl))
		{
			dir.y -= 1.0f;
			movementSpeed += 0.2f;
		}
		if (Input.anyKey == false)
		{ movementSpeed = 10f; }

		
		dir.Normalize();
		transform.Translate(dir * movementSpeed * Time.deltaTime);

				if(Input.GetKeyDown(KeyCode.Escape) == true)
				{
					Application.Quit();
				}
				if (axes == RotationAxes.MouseXAndY)
				{
					float rotationX = transform.localEulerAngles.y + Input.GetAxis("Mouse X") * sensitivityX;
					
					rotationY += Input.GetAxis("Mouse Y") * sensitivityY;
					rotationY = Mathf.Clamp (rotationY, minimumY, maximumY);
					//	float yAngle = Mathf.SmoothDampAngle(position.y, transform.eulerAngles.y, ref yVelocity, smooth);
					//	float xAngle = Mathf.SmoothDampAngle(position.x, transform.eulerAngles.x, ref yVelocity, smooth);
					
					transform.localEulerAngles = new Vector3(-rotationY, rotationX, 0);
					//transform.localEulerAngles.y = Mathf.SmoothDampAngle(position.y, NewAngles.eulerAngles.y, ref yVelocity, smooth);
					//	transform.localEulerAngles.x = Mathf.SmoothDampAngle(position.x, NewAngles.eulerAngles.x, ref xVelocity, smooth);
				}
				else if (axes == RotationAxes.MouseX)
				{
					
					transform.Rotate(0, Input.GetAxis("Mouse X") * sensitivityX, 0);
					//	float xAngle = Mathf.SmoothDampAngle(position.x, transform.eulerAngles.x, ref yVelocity, smooth);
				}
				else
				{
					
					rotationY += Input.GetAxis("Mouse Y") * sensitivityY;
					rotationY = Mathf.Clamp (rotationY, minimumY, maximumY);
					//float yAngle = Mathf.SmoothDampAngle(position.y, transform.eulerAngles.y, ref yVelocity, smooth);
					
					
					transform.localEulerAngles = new Vector3(-rotationY, transform.localEulerAngles.y, 0);
				}
		}
	}
	
	

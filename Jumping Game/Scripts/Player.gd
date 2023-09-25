extends CharacterBody3D


const MIN_SPEED = 0.1
const MAX_SPEED=10.0
const JUMP_VELOCITY = 4.5
  
var jump_pressed_time = 0.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
		
func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_on_floor():
		velocity.z=0;
		
	if Input.is_action_pressed("Jump"):
		jump_pressed_time += delta
		
	# Handle Jump.
	if Input.is_action_just_released("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		velocity.z=lerp(MIN_SPEED, MAX_SPEED, jump_pressed_time)
		jump_pressed_time=0;
		$AnimationPlayer.play("Spin")

	move_and_slide()

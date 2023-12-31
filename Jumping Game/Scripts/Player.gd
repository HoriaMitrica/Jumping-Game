extends CharacterBody3D


const MIN_SPEED = 0.1
const MAX_SPEED=10.0
const JUMP_VELOCITY = 4.5
var rotated:bool=false
var jump_pressed_time = 0.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
		
func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_on_floor():
		velocity.z=0
		velocity.x=0
		
	if Input.is_action_pressed("Jump"):
		jump_pressed_time += delta
		
	# Handle Jump.
	if Input.is_action_just_released("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if !rotated:
			velocity.z=lerp(MIN_SPEED, MAX_SPEED, jump_pressed_time)
			$AnimationPlayer.play_backwards("Spin")
		else:
			velocity.x=lerp(MIN_SPEED, MAX_SPEED, jump_pressed_time)
			$AnimationPlayer.play_backwards("Spin_2")
		jump_pressed_time=0;
	move_and_slide()


func _on_level_rotate():
	rotated=!rotated
	if rotated:
		$MeshInstance3D.rotation_degrees.y=90
	else:
		$MeshInstance3D.rotation_degrees.y=0
	pass # Replace with function body.

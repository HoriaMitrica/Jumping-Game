extends CharacterBody3D


const MIN_SPEED = 0.1
const MAX_SPEED=10.0
const JUMP_VELOCITY = 4.5
var rotated:bool=false
var player_ofset_z:float
var player_ofset_x:float=0.1
var needs_centering_z:bool
var needs_centering_x:bool
var jump_pressed_time = 0.0
var animation_playing = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")




func playAnimation():
	if not animation_playing:
		$AnimationPlayer.play("WindUp")
		animation_playing = true
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_on_floor():
		velocity.z=0
		velocity.x=0
		
	if Input.is_action_pressed("Jump"):
		playAnimation()
		jump_pressed_time += delta
		
	# Handle Jump.
	if Input.is_action_just_released("Jump") and is_on_floor():
		animation_playing=false;
		velocity.y = JUMP_VELOCITY
		if !rotated:
			velocity.z=lerp(MIN_SPEED, MAX_SPEED, jump_pressed_time)
			#$AnimationPlayer.play_backwards("Spin")
		else:
			velocity.x=lerp(MIN_SPEED, MAX_SPEED, jump_pressed_time)
			#$AnimationPlayer.play_backwards("Spin_2")
		jump_pressed_time=0;
	move_and_slide()


func _on_level_rotate():
	rotated=!rotated
	if rotated:
		$Boorgy.rotation_degrees.y=270
	else:
		$Boorgy.rotation_degrees.y=180
	pass # Replace with function body.

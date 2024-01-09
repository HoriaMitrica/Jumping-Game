extends CharacterBody3D


const MIN_SPEED = 0.1
const MAX_SPEED=10.0
const JUMP_VELOCITY = 4.5
var rotated:bool=false
var player_ofset_z:float
var center_offset_z=0.0
var center_offset_x=0.0
var offset_correction_speed=1.1
var player_ofset_x:float=0.1
var needs_centering_z:bool
var needs_centering_x:bool
var jump_pressed_time = 0.0
var animation_playing = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func playAnimation(animation_name:String):
	if not animation_playing:
		$AnimationPlayer.play(animation_name)
		animation_playing = true
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_on_floor():
		velocity.z=0
		velocity.x=0
		
	if Input.is_action_pressed("Jump"):
		playAnimation("WindUp")
		jump_pressed_time += delta
		
	# Handle Jump.
	if Input.is_action_just_released("Jump") and is_on_floor():
		animation_playing=false;
		playAnimation("Jump")
		velocity.y = JUMP_VELOCITY
		if !rotated:
			velocity.z=lerp(MIN_SPEED, MAX_SPEED, jump_pressed_time)
			velocity.x += center_offset_x * offset_correction_speed;
		else:
			velocity.x=lerp(MIN_SPEED, MAX_SPEED, jump_pressed_time)
			velocity.z += center_offset_z * offset_correction_speed;
		jump_pressed_time=0;
	move_and_slide()

func _on_level_landed():
	$AnimationPlayer.play("WindDown")
	animation_playing=false;

func _on_level_rotate():
	rotated=!rotated
	if rotated:
		$Boorgy.rotation_degrees.y=90
	else:
		$Boorgy.rotation_degrees.y=0
	pass # Replace with function body.


func _on_level_center_offset(amount, forward):
	if(forward):
		print("offset x: ",amount)
		center_offset_x=amount
		center_offset_z=0;
	else:
		print("offset z: ",amount)
		center_offset_x=0
		center_offset_z=amount;
	pass # Replace with function body.

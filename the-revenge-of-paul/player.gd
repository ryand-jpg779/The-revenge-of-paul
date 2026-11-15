extends CharacterBody2D

const SPEED = 500.0
const DASH_SPEED = 1800.0
const DASH_DURATION = 0.15
const DASH_COOLDOWN = 1.0

var is_dashing = false
var can_dash = true
var last_direction = Vector2.RIGHT

func _physics_process(delta):
	var input_direction = Vector2(
		int(Input.is_physical_key_pressed(KEY_D)) - int(Input.is_physical_key_pressed(KEY_A)),
		int(Input.is_physical_key_pressed(KEY_S)) - int(Input.is_physical_key_pressed(KEY_W))
	).normalized()
	
	if input_direction != Vector2.ZERO:
		last_direction = input_direction
	
	# Only dash when F is pressed, cooldown is ready, not already dashing, AND moving
	if Input.is_physical_key_pressed(KEY_F) and can_dash and not is_dashing and input_direction != Vector2.ZERO:
		start_dash()
	
	if not is_dashing:
		velocity = input_direction * SPEED
		
	move_and_slide()

func start_dash():
	is_dashing = true
	can_dash = false
	
	velocity = last_direction.normalized() * DASH_SPEED
	
	await get_tree().create_timer(DASH_DURATION).timeout
	is_dashing = false
	
	await get_tree().create_timer(DASH_COOLDOWN).timeout
	can_dash = true
	

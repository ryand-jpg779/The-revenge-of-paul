extends AnimatedSprite2D

var last_direction = "backward" 

func _process(delta):
	if get_parent().is_dashing:
		speed_scale = 2.5
	else:
		speed_scale = 1.0

	if Input.is_physical_key_pressed(KEY_D):
		last_direction = "right"
		play("Paul walk right")
	elif Input.is_physical_key_pressed(KEY_A):
		last_direction = "left"
		play("Paul walk left")
	elif Input.is_physical_key_pressed(KEY_W):
		last_direction = "forward"
		play("Paul walk forward")
	elif Input.is_physical_key_pressed(KEY_S):
		last_direction = "backward"
		play("Paul walk backward")
	else:
		play("Paul walk " + last_direction + " idle")

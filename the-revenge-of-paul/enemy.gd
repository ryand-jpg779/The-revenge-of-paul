
extends CharacterBody2D

var Player = null
@export var speed = 5.0
@export var dash_speed = 15.0
@export var dash_duration = 0.25
@export var dash_chance = 0.35 # 35% chance to dash each time the timer triggers

var is_dashing = false
var dash_direction = Vector2.ZERO

func _ready():
	# Create a timer in code to periodically check for a random dash
	var check_timer = Timer.new()
	check_timer.wait_time = 1.5 # Checks every 1.5 seconds
	check_timer.autostart = true
	check_timer.timeout.connect(_on_dash_check_timeout)
	add_child(check_timer)

func _on_Detection_body_entered(body):
	if body.is_in_group("Player"):
		Player = body

func _on_dash_check_timeout():
	# Only dash if the player is detected, not already dashing, and the random roll succeeds
	if Player and not is_dashing:
		if randf() < dash_chance:
			start_dash()

func start_dash():
	is_dashing = true
	# Lock in the direction toward the player at the start of the dash
	dash_direction = global_position.direction_to(Player.global_position)

	await get_tree().create_timer(dash_duration).timeout
	is_dashing = false

func _physics_process(delta):
	var movement = Vector2(-2, 0)

	if Player:
		if is_dashing:
			movement = dash_direction * dash_speed
		else:
			movement = global_position.direction_to(Player.global_position) * speed

	move_and_collide(movement)

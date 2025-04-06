extends CharacterBody2D

var speed = 350
var jump = -350
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var super_speed = 2.5
var sliding = false
var last_direction = 1 
var slide_direction = 0
@onready var slide_timer: Timer = $slide_timer

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if not sliding :
		if Input.is_action_pressed("right"):
			direction.x += 1
		if Input.is_action_pressed("left"):
			direction.x -= 1
		if direction.x != 0:
			last_direction = direction.x
		if Input.is_action_pressed("shift") and is_on_floor():
			sliding = true
			slide_direction = last_direction
			slide_timer.start()
	if sliding:
		velocity.x = slide_direction * speed * super_speed
	else:
		velocity.x = direction.x * speed
		
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump

	move_and_slide()


func _on_slide_timer_timeout() -> void:
	sliding = false

extends RigidBody2D

var move_force = 1000
var is_jacinto_inside = false
var control_enabled = false
var jacinto_ref: Node = null

@onready var wheel: Area2D = $Wheel

func _ready():
	linear_damp=5
	angular_damp = 3
	wheel.body_entered.connect(_on_wheel_body_entered)
	wheel.body_exited.connect(_on_wheel_body_exited)

func _physics_process(delta: float) -> void:
	if is_jacinto_inside and Input.is_action_just_pressed("action"):
		control_enabled = !control_enabled
		if jacinto_ref:
			jacinto_ref.controlling_boat = control_enabled

	if control_enabled:
		_movement_boat(delta)
	
func _movement_boat(delta: float)->void:
	if Input.is_action_pressed("left"):
		apply_central_impulse(Vector2(-move_force * delta, 0))
	elif Input.is_action_pressed("right"):
		apply_central_impulse(Vector2(move_force * delta, 0))
		
func _on_wheel_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jacinto"):
		is_jacinto_inside = true
		jacinto_ref = body
		
func _on_wheel_body_exited(body: Node2D) -> void:
	if body == jacinto_ref:
		is_jacinto_inside = false
		control_enabled = false
		if jacinto_ref:
			jacinto_ref.controlling_boat = false
		jacinto_ref = null

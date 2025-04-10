extends CharacterBody2D

@export var speed: float = 100
@export var patrol_distance: float = 200

var direction := Vector2.RIGHT
var start_position := Vector2.ZERO
@onready var animated_sprite: AnimatedSprite2D  = $AnimatedSprite2D 

func _ready():
	start_position = position

func _physics_process(delta):
	# Mueve al NPC en la dirección actual
	velocity.x = direction.x * speed
	move_and_slide()

	# Calcula la distancia desde la posición inicial
	var distance_from_start = position.x - start_position.x

	# Cambia de dirección si se pasa del límite
	if abs(distance_from_start) >= patrol_distance:
		direction *= -1  # Invierte la dirección
		if direction.x == -1:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false

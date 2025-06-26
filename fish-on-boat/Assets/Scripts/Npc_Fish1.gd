extends CharacterBody2D

@export var speed: float = 100
@export var patrol_distance: float = 200

var direction := Vector2.RIGHT
var start_position := Vector2.ZERO
@onready var animated_sprite: AnimatedSprite2D  = $AnimatedSprite2D 
var just_spawned := true

func _ready():
	start_position = position
	var available_fish = ["pez1", "pez2", "pez3", "pez4", "pez5"]
	var selected_fish = available_fish[randi() % available_fish.size()]
	animated_sprite.play(selected_fish)
		# Desactiva flag just_spawned después de 0.2 segundos
	await get_tree().create_timer(0.2).timeout
	just_spawned = false
	
func _physics_process(delta):
	# Mueve al NPC en la dirección actual
	velocity.x = direction.x * speed
	move_and_slide()

	# Calcula la distancia desde la posición inicial
	var distance_from_start = position.x - start_position.x

	# Cambia de dirección si se pasa del límite
	if abs(distance_from_start) >= patrol_distance:
		direction *= -1  # Invierte la dirección
		animated_sprite.flip_h = direction.x == -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if just_spawned:
		return  # ignora colisiones si recién apareció
	if body.is_in_group("fish") and body != self:
		queue_free()

extends Control

# Velocidad de desplazamiento
@export var velocidad_scroll := 50.0

@onready var b_play: Button = $ContainerPlay/B_Play
@onready var pantalla_transicion: Node = $PantallaTransicion  # Ajusta si está en otra ruta

func _ready() -> void:
	Engine.time_scale = 1  # ← aseguramos que el juego no esté congelado al volver
	b_play.disabled = false

func _on_b_play_pressed() -> void:
	b_play.disabled = true

	# Verificamos que la transición exista antes de usarla
	if pantalla_transicion:
		pantalla_transicion._transition()
		await pantalla_transicion._on_animation_finished
	else:
		print("⚠️ PantallaTransicion no encontrada, saltando animación.")

	get_tree().change_scene_to_file("res://Scenes/Gameplay/top_world.tscn")

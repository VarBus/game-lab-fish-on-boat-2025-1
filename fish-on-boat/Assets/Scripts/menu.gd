extends Control

# Velocidad de desplazamiento
@export var velocidad_scroll := 50.0


func _on_b_play_pressed() -> void:
	PantallaTransición._transition()
	await PantallaTransición._on_animation_finished
	get_tree().change_scene_to_file("res://Scenes/top_world.tscn")

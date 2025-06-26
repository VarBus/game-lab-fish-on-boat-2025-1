extends Control

@onready var node_2d: Node2D = $"../../UI/Node2D"


func _on_play_pressed() -> void:
	node_2d.pauseMenu()


func _on_menu_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/parallax_background.tscn")

extends Control


func _on_reanudar_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Gameplay/top_world.tscn")


func _on_noob_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Interfaces/parallax_background.tscn")

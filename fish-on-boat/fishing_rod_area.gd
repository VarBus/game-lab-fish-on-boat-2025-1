extends Area2D

signal item_selected(item_scene)
const ITEM_SCENE := preload("res://fishing_rod.tscn")

func _input_event(viewport, event, shape_idx):
	var item_instance = ITEM_SCENE.instantiate()
	if event is InputEventMouseButton and event.pressed:
		print("🎯 Ítem del inventario clickeado")
		emit_signal("item_selected", item_instance)

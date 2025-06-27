extends Area2D
signal item_selected(item_scene)

@export var item_scene: PackedScene  # ← aquí arrastras la escena fishing_rod.tscn desde el editor

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("🎯 Ítem del inventario clickeado")
		emit_signal("item_selected", item_scene)

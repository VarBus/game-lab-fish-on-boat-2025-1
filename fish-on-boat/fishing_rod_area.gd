extends Area2D

@export var item_scene: PackedScene  # 👉 Esto debe ser la escena funcional, como la "fishing_rod.tscn"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("🎯 Ítem del inventario clickeado")
		emit_signal("item_selected", item_scene)

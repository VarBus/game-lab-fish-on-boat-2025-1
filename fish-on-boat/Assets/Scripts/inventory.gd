extends Node2D

signal give_item_to_jacinto(item_scene)

@onready var inventory: Node2D = $"."  # o tu contenedor visual
var inventory_visible := true
const FISHING_ROD_SCENE := preload("res://Scenes/Herramientas/fishing_rod.tscn")

func _ready():
	for child in get_children():
		if child.has_signal("item_selected"):
			child.connect("item_selected", Callable(self, "_on_item_selected"))

func _on_item_selected(item_scene):
	var instance = item_scene.duplicate()
	emit_signal("give_item_to_jacinto", instance)


func _on_btn_inventory_pressed() -> void:
		inventory_visible = !inventory_visible
		inventory.visible = inventory_visible

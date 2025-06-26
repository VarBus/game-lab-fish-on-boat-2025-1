extends Node2D

@export var fish_scene: PackedScene
@export var spawn_area: Rect2 = Rect2(Vector2(0, 400), Vector2(800, 1400))

func _ready():
	randomize()
	spawn_fish()

func spawn_fish():
	var fish = fish_scene.instantiate()
	var spawn_position = Vector2(
		randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
		randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	)
	fish.position = spawn_position
	add_child(fish)


func _on_timer_timeout() -> void:
	spawn_fish()

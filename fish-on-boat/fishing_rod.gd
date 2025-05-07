extends Area2D

signal item_selected(item_scene)

@onready var rope: Line2D = $Rope
const ITEM_SCENE := preload("res://fishing_rod.tscn")

var is_casting = false
var rope_speed = 200.0
var rope_points: Array = []

var jacinto_ref: Node = null
var camera_ref: Camera2D = null

var last_click_time := 0.0
const DOUBLE_CLICK_TIME := 0.3

func _ready():
	rope.visible = false
	rope.clear_points()
	set_process_input(true)
	


# Solo lanza la caña cuando haces clic sobre la caña
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and not is_casting:
		var item_instance = ITEM_SCENE.instantiate()
		emit_signal("item_selected", item_instance)
		is_casting = true
		rope_points.clear()
		rope_points.append(Vector2.ZERO)
		rope.visible = true

# 🟡 Detecta doble clic sobre la línea (la cuerda)
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if is_casting and rope_points.size() > 0:
			var mouse_pos = get_global_mouse_position()
			var rope_tip = rope.to_global(rope_points[-1])

			if rope_tip.distance_to(mouse_pos) < 50:
				var current_time = Time.get_ticks_msec() / 1000.0
				if current_time - last_click_time < DOUBLE_CLICK_TIME:
					_return_camera_to_jacinto()
					return
				last_click_time = current_time

func _physics_process(delta: float) -> void:
	if is_casting:
		var mouse_pos = get_global_mouse_position()
		var direction = (mouse_pos - global_position).normalized()
		var last_point = rope_points[-1]
		var new_point = last_point + direction * rope_speed * delta
		rope_points.append(new_point)
		rope.points = rope_points

		if camera_ref:
			camera_ref.global_position = rope.to_global(rope_points[-1])

func _return_camera_to_jacinto():
	print("🔙 Volviendo cámara a Jacinto")
	if jacinto_ref and camera_ref:
		camera_ref.global_position = jacinto_ref.global_position
	is_casting = false
	rope_points.clear()
	rope.visible = false

func connect_to_jacinto(jacinto):
	jacinto_ref = jacinto
	jacinto_ref.connect("camera_following", Callable(self, "_on_camera_following"))

func _on_camera_following(camera):
	camera_ref = camera
	print("📷 Cámara recibida: ", camera.name)
	if is_casting and rope_points.size() > 0:
		camera_ref.global_position = rope.to_global(rope_points[-1])

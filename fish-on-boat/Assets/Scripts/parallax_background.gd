extends ParallaxBackground

# Velocidad de desplazamiento
@export var velocidad_scroll := 50.0

func _input(event):
	if event is InputEventKey and event.pressed:
		PantallaTransición._transition()
		await PantallaTransición._on_animation_finished
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
				
func _process(delta):
	scroll_base_offset.x += velocidad_scroll * delta

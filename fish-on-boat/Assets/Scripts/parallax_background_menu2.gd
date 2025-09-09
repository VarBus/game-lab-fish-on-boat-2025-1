extends ParallaxBackground

# Velocidad de desplazamiento
@export var velocidad_scroll := 50.0

func _process(delta):
	scroll_base_offset.x += velocidad_scroll * delta

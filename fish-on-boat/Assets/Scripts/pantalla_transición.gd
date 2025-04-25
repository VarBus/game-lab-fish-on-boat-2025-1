extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player= $AnimationPlayer

func _ready():
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
		if anim_name == "Transición_escenas":
			on_transition_finished.emit()
			animation_player.play("Transición_2")
		elif anim_name == "Transición_2":
			color_rect.visible = false
func _transition():
	color_rect.visible = true	
	animation_player.play("Transición_2") 

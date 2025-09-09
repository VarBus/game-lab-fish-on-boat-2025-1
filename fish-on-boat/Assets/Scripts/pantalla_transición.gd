extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player= $AnimationPlayer

func _ready():
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
		if anim_name == "Ola_safa":
			on_transition_finished.emit()
			color_rect.visible = false
			#animation_player.play_backwards("Ola_safa")
		#elif anim_name == "Ola_safa":
			#color_rect.visible = false
func _transition():
	color_rect.visible = true	
	animation_player.play("Ola_safa") 

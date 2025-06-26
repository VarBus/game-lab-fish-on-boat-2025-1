extends ParallaxBackground
# Velocidad de desplazamiento
@export var velocidad_scroll := 50.0
@onready var select_btn: AudioStreamPlayer2D = $select_btn
var cambiando_escena := false

func _ready() -> void:
	Engine.time_scale = 1
		# Detener música
	MusicManager.music_player.stop()
# Cambiar de canción
	MusicManager.music_player.stream = load("res://SoundEffects/menu/1.wav")
	MusicManager.music_player.play()
#func _input(event):
	#if event is InputEventKey and event.pressed:
		#$select_btn.play()
		#PantallaTransición._transition()
		#await PantallaTransición._on_animation_finished
		#get_tree().change_scene_to_file("res://Scenes/Interfaces/menu.tscn")
				
func _input(event):
	if event is InputEventKey and event.pressed and not cambiando_escena:
		cambiando_escena = true
		print("🎵 Reproduciendo sonido...")
		select_btn.play()
		await get_tree().create_timer(0.8).timeout  
		get_tree().change_scene_to_file("res://Scenes/Interfaces/menu.tscn")
func _process(delta):
	scroll_base_offset.x += velocidad_scroll * delta

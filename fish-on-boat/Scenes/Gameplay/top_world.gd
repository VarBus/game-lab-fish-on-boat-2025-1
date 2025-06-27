extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var log_book: TextureButton = $UI/log_book
var abierto = false

func _ready() -> void:
	# Detener música
	MusicManager.music_player.stop()
# Cambiar de canción
	MusicManager.music_player.stream = load("res://SoundEffects/menu/intro.mp3")
	MusicManager.music_player.play()


func _on_log_book_pressed() -> void:
	if abierto:
		animation_player.play("RESET")
	else:
		animation_player.play("task")
	abierto = !abierto

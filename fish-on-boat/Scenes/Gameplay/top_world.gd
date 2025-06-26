extends Node2D

func _ready() -> void:
	# Detener música
	MusicManager.music_player.stop()
# Cambiar de canción
	MusicManager.music_player.stream = load("res://SoundEffects/menu/intro.mp3")
	MusicManager.music_player.play()

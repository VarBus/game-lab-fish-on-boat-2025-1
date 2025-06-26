extends Node

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = "Music"  # Puedes cambiarlo si tienes otro bus
	music_player.autoplay = false
	music_player.stream = load("res://SoundEffects/menu/1.wav")  # <-- pon tu música aquí
	music_player.play()

extends Node2D
@onready var pause: Control = $"../../UI2/Pause"

var paused = false
var escapePressed = false
func _process(delta):
	if Input.is_action_pressed("paused") and not paused:
		pauseMenu()
		escapePressed = true
	elif Input.is_action_pressed("ui_cancel") and escapePressed:
		# Aquí puedes agregar lógica adicional si es necesario,
		# como reproducir un sonido o mostrar un mensaje.
		# Por ahora, simplemente ignoramos la tecla Escape.
		
		pass

func pauseMenu():
	
	if paused:
		pause.hide()
		Engine.time_scale = 1
	else:
		pause.show()
		Engine.time_scale = 0
	paused = !paused

	if paused:
		escapePressed = false

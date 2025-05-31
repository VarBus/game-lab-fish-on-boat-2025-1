extends Area2D

# Guardamos los cuerpos que están dentro del agua
var bodies_in_water := []

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("Jacinto"):
		if not bodies_in_water.has(body):
			bodies_in_water.append(body)
			body.enter_water() # Jacinto comienza a hundirse/nadar

	elif body.is_in_group("Jacinto_boat"):
		print("⛵ Barco entró al agua, pero no se hunde.")

func _on_body_exited(body):
	if body.is_in_group("Jacinto"):
		if body in bodies_in_water:
			bodies_in_water.erase(body)
			body.exit_water() # Jacinto deja de nadar

	elif body.is_in_group("Jacinto_boat"):
		print("⛵ Barco salió del agua.")

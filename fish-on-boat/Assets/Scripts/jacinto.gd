extends CharacterBody2D

signal camera_following(camera_node)
@onready var progress_bar: ProgressBar = $"../CanvasLayer/ProgressBar"
var speed = 350
var jump = -450
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var super_speed = 2.5
var sliding = false
var last_direction = 1
var slide_direction = 0
var in_water = false
var swim_force = -300 # Fuerza al presionar espacio en agua
var damage = 20
var was_moving = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var inventory: Node2D = $UI/Inventory
@onready var slide_timer: Timer = $slide_timer
@onready var hand_slot: Marker2D = $HandSlot
@onready var camera_2d: Camera2D = $Camera2D

var controlling_boat = false

func _ready() -> void:
	inventory.connect("give_item_to_jacinto", Callable(self, "_receive_item"))

func _physics_process(delta: float) -> void:
	if controlling_boat:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var direction = Vector2.ZERO

	if not sliding:
		if Input.is_action_pressed("right"):
			direction.x += 1
			animated_sprite_2d.flip_h = true
		if Input.is_action_pressed("left"):
			direction.x -= 1
			animated_sprite_2d.flip_h = false

		if direction.x != 0 and not $piso.playing:
			$piso.play()
			was_moving = true
		elif direction.x == 0 and was_moving:
			$piso.stop()
			was_moving = false

		if direction.x != 0:
			last_direction = direction.x

		if Input.is_action_pressed("shift") and is_on_floor():
			sliding = true
			slide_direction = last_direction
			slide_timer.start()

	if sliding:
		velocity.x = slide_direction * speed * super_speed
	else:
		velocity.x = direction.x * speed

	# Lógica de caída/nado
	if in_water:
		velocity.y += gravity * delta * 0.3 # Menor gravedad bajo el agua
		if Input.is_action_pressed("up") or Input.is_action_pressed("ui_accept") or Input.is_action_pressed("jump") or Input.is_action_pressed("space"):
			velocity.y = swim_force
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = jump

	move_and_slide()

func _on_slide_timer_timeout() -> void:
	sliding = false

func _receive_item(item_instance):
	for child in hand_slot.get_children():
		child.queue_free()
	item_instance.position = Vector2.ZERO
	item_instance.visible = true
	hand_slot.add_child(item_instance)

	if item_instance.has_method("connect_to_jacinto"):
		item_instance.connect_to_jacinto(self)

	emit_signal("camera_following", camera_2d)
	print("🎣 Item recibido: ", item_instance.name)

# ==== Métodos llamados desde el área de agua ====

func enter_water():
	in_water = true
	print("🌊 Jacinto entró al agua.")

func exit_water():
	in_water = false
	print("🌊 Jacinto salió del agua.")


func _on_damage_body_entered(body: Node2D) -> void:
	print("Detectado:", body.name)
	if body.is_in_group("fish"):
		print("⚠️ Pez detectado: bajando vida")
		
		if progress_bar:
			progress_bar.value -= damage
			print("💡 Nueva vida:", progress_bar.value)

			if progress_bar.value <= 0:
				velocity = Vector2.ZERO
				print("💀 Jacinto ha muerto.")

		$AnimationPlayer.play("auch")
		body.queue_free()

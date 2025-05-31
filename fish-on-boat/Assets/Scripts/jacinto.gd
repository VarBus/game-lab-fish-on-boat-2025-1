extends CharacterBody2D

signal camera_following(camera_node) # Declara la señal aquí

var speed = 350
var jump = -450
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var super_speed = 2.5
var sliding = false
var last_direction = 1 
var slide_direction = 0
<<<<<<< HEAD
=======
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
>>>>>>> origin/ZtanQ_Develop
@onready var inventory: Node2D = $UI/Inventory
@onready var slide_timer: Timer = $slide_timer
var controlling_boat = false
@onready var hand_slot: Marker2D = $HandSlot
@onready var camera_2d: Camera2D = $Camera2D

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
<<<<<<< HEAD
			$Sprite2D.flip_h = true
		if Input.is_action_pressed("left"):
			direction.x -= 1
			$Sprite2D.flip_h = false
=======
			animated_sprite_2d.flip_h = true
		if Input.is_action_pressed("left"):
			direction.x -= 1
			animated_sprite_2d.flip_h = false
>>>>>>> origin/ZtanQ_Develop
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

	# Si el ítem es FishingRod, le pasamos la referencia de Jacinto
	if item_instance.has_method("connect_to_jacinto"):
		item_instance.connect_to_jacinto(self)

	# Emitimos señal con la cámara
	emit_signal("camera_following", camera_2d)

	print("🎣 Item recibido: ", item_instance.name)

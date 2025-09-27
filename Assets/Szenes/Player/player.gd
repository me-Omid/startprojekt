extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -430.0

var start_position: Vector2

func _ready() -> void:
	# Startposition merken
	start_position = global_position

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Bewegung + Kollision prüfen
	var collision = move_and_slide()
	if collision:
		for i in range(get_slide_collision_count()):
			var col = get_slide_collision(i)
			if col.get_collider().name == "Spike":  # Prüft, ob die TileMap Spike ist
				global_position = start_position  # Spieler zurücksetzen
			if col.get_collider().name == "Spike_Ball":  # Prüft, ob die TileMap Spike ist
				global_position = start_position  # Spieler zurücksetzen	

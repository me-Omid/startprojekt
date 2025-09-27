extends RigidBody2D

@onready var floor_ray = $FloorRay

const JUMP_FORCE = Vector2(0, -800)  # nach oben
var can_jump: bool = true

func _ready():
	floor_ray.enabled = true
	mass = 1  # sicherstellen, dass der Body nicht zu schwer ist

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if can_jump and floor_ray.is_colliding():
		# Impuls nach oben geben
		linear_velocity.y = JUMP_FORCE.y
		can_jump = false
	elif not can_jump and floor_ray.is_colliding():
		can_jump = true

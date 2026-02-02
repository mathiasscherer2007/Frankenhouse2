extends Node3D
class_name Health

@export var health : float = 100

func take_damage(damage_recieved: float) -> void:
	health -= damage_recieved
	
	if owner.is_in_group("Player"):
		owner.emit_signal("health_updated", health)
	
	if health <= 0:
		owner.die()

func get_health() -> float:
	return health

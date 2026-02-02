extends State

func enter(_previous_state_path: String, _data := {}) -> void:
	# Linha vudu pra não dar fatal error quando o inimigo morre (?)
	if is_instance_valid(owner):
		owner.velocity.x = 0.0
	print("we are chilling (standing still)")

func physics_update(_delta: float) -> void:
	owner.velocity = owner.get_gravity() * _delta
	owner.move_and_slide()

func _on_spot_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		finished.emit("Chasing")
		return

extends State

var player_in_range = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var damage_cooldown = $"../../DamageAreas/DamageCooldown"

func enter(_previous_state_path: String, _data := {}) -> void:
	pass

func physics_update(_delta: float) -> void:
	var target = get_tree().get_first_node_in_group("Player").global_transform.origin
	owner.nav_agent.target_position = target
	target.y = owner.global_transform.origin.y
	
	var currentLocation = owner.global_transform.origin
	var nextLocation = owner.nav_agent.get_next_path_position()
	var newVelocity = (nextLocation - currentLocation).normalized() * owner.SPEED
	
	var target_look = nextLocation
	target_look.y = owner.global_position.y
	if target_look != currentLocation:
		owner.look_at(target_look, Vector3.UP)
	
	if player_in_range:
		if damage_cooldown.is_stopped():
			player.health.take_damage(owner.DAMAGE)
			damage_cooldown.start()
		newVelocity = Vector3(0, 0, 0)
	
	owner.velocity = owner.velocity.move_toward(newVelocity, 0.25)
	owner.move_and_slide()

func _on_clobber_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true


func _on_clobber_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false

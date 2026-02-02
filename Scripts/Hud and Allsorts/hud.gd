extends Control

@onready var ammo = $AmmoCounter
@onready var health = $HealthCounter

func _ready() -> void:
	var gun = get_tree().get_first_node_in_group("Gun")
	if gun:
		gun.ammo_updated.connect(_on_ammo_update)
		_on_ammo_update(gun.ammo)

func _on_ammo_update(current_ammo: int):
	ammo.text = "Boolets: " + str(current_ammo)

func _on_player_health_updated(current_health: Variant) -> void:
	health.text = "Health: " + str(int(current_health))

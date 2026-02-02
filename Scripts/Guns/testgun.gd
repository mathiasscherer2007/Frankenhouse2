extends Node3D

@onready var audioplayer = $ShootingSound
@onready var firerate = $FireRate
@onready var animationplayer = $AnimationPlayer

@export var damage = 50
@export var ammo = 10

signal ammo_updated(current_ammo)

func emit_ammo_update() -> void:
	emit_signal("ammo_updated", ammo)

func add_ammo(ammount: int) -> void:
	ammo += ammount

func shoot() -> void:
	if ammo > 0:
			if firerate.is_stopped(): # Only shoot if has ammo and if firerate allows
				audioplayer.play()
				ammo -= 1
				animationplayer.play("Shooting")
				firerate.start()
				emit_signal("ammo_updated", ammo)

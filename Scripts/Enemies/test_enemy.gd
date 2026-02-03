extends CharacterBody3D

@onready var nav_agent := $NavigationAgent3D
@onready var health := $Health
@onready var state_machine := $StateMachine

@export var SPEED := 2.0
@export var DAMAGE := 30.0

var ammo_drop = preload("res://Scenes/Guns/ammo_box.tscn")

func die() -> void:
	var pos = self.global_position
	spawn_death_item(pos)
	self.queue_free()

func spawn_death_item(pos: Vector3):
	var instance = ammo_drop.instantiate()
	instance.global_position = pos
	instance.position.y += 0.5
	get_parent().add_child(instance)

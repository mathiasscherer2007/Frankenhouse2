extends Node
class_name State

# Classe que serve como uma interface para estados.
# Para implementar um estado, basta extender essa classe e fazer override dos seus métodos.

signal finished(next_state_path: String, data: Dictionary)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func enter(_previous_state_path: String, _data := {}) -> void:
	pass

func exit() -> void:
	pass

func _ready() -> void:
	await owner.ready

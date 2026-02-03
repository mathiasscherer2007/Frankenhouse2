extends Node3D
class_name PickupItem

var t_bob = 0

func _ready() -> void:
	start_bobbing()

func _process(_delta: float) -> void:
	self.rotate(Vector3(0, 1, 0), 0.01)

func start_bobbing():
	var tween = create_tween().set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", position.y + 0.1, 1.0)
	tween.tween_property(self, "position:y", position.y, 1.0)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		body.weapon_manager.gun.add_ammo(10)
		body.weapon_manager.gun.emit_ammo_update()
		queue_free()

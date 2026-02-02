extends Node3D

@onready var gun = get_tree().get_first_node_in_group("Gun")

func draw_hitscan():
	var camera = get_viewport().get_camera_3d()
	var viewport = get_viewport().get_visible_rect().size
	
	var ray_origin = camera.project_ray_origin(viewport/2)
	var ray_end = ray_origin + camera.project_ray_normal(viewport/2)*500
	
	var new_intersection = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var intersect = get_world_3d().direct_space_state.intersect_ray(new_intersection)
	
	if not intersect.is_empty():
		return intersect
	else:
		return 

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		if gun.firerate.is_stopped():
			var hit = draw_hitscan()
			if hit:
				if hit.collider.is_in_group("Enemies"):
					hit.collider.health.take_damage(gun.damage)
		gun.shoot()

extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 3
const SENSITIVITY = 0.003

var t_bob = 0

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var light = $Flashlight
@onready var weapon_manager = $Head/WeaponManager
@onready var health = $Health

signal health_updated(current_health)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	emit_signal("health_updated", health.get_health())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * SENSITIVITY)
		head.rotate_x(-event.relative.y * SENSITIVITY)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		light.rotation.x = head.rotation.x

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_FORWARD", "MOVE_BACKWARD")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 0.4)
		velocity.z = move_toward(velocity.z, 0, 0.4)
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	var pos = Vector3.ZERO
	pos.x = sin(t_bob * 1) * 0.01
	pos.y = weapon_manager.position.y
	weapon_manager.transform.origin = pos
	
	move_and_slide()

func die():
	get_tree().quit()

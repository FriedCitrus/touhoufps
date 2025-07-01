class_name Player extends CharacterBody3D

#const  JUMP_VELOCITY = 9.5

var mouse_input : bool = false
var rotation_input : float
var tilt_input : float
var mouse_rotation: Vector3
var player_rotation: Vector3
var camera_rotation: Vector3
var current_rotation: float

@export var MOUSE_SENS : float = 0.5
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA : Camera3D
@export var AnimPlayer: AnimationPlayer

var _is_crouching: bool = false

#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 20

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Gloabal.player = self
	
func _update_camera(delta) -> void:
	current_rotation = rotation_input
	mouse_rotation.x +=  tilt_input * delta
	mouse_rotation.x = clamp(mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	mouse_rotation.y += rotation_input * delta
	
	player_rotation = Vector3(0,mouse_rotation.y,0)
	camera_rotation = Vector3(mouse_rotation.x,0,0)
	
	CAMERA.transform.basis = Basis.from_euler(camera_rotation)
	CAMERA.rotation.z = 0.0
	
	global_transform.basis = Basis.from_euler(player_rotation)
	
	rotation_input = 0
	tilt_input = 0
	
func _unhandled_input(event: InputEvent) -> void:
	mouse_input = event is  InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	if  mouse_input:
		rotation_input =  -event.relative.x * MOUSE_SENS
		tilt_input = -event.relative.y * MOUSE_SENS

func _physics_process(delta: float) -> void:
	
	Gloabal.debug.add_prop("Speed", velocity, 2)
	Gloabal.debug.add_prop("MouseRotation", mouse_rotation, 3)
	
	_update_camera(delta)

func update_gravity(delta):
	velocity.y -= gravity * delta

func update_input(speed: float, acceleration: float, deceleration: float = 0.5):
	var input_dir = Input.get_vector("left","right","forward","backward")
	var dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if dir:
		velocity.x = lerp(velocity.x, dir.x * speed, acceleration)
		velocity.z = lerp(velocity.z, dir.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)

func update_velocity():
	move_and_slide()

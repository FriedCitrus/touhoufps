class_name Player extends CharacterBody3D

var input_dir: Vector2 = Vector2.ZERO
var movement_velocity: Vector3 = Vector3.ZERO

var dash_modifier: float = 0
var crouch_modifier: float = 0
var slide_modifier: float = 0
var speed = 0

const DEFAULT_HEIGHT = 0.5

@export var interaction_cast: RayCast3D 
@export_category("Speed")

@export_group("Variables")
@export var default_speed: float = 7.0 
@export var dash_speed: float = 10.0
@export var crouch_speed: float = -2
@export var slide_speed: float = 12.0

@export_group("Easing")
@export var acceleration: float = 0.2
@export var deceleration: float = 0.5

@export_category("References")

@export var camera : CameraControl
@export var state_chart : StateChart

@export_group("Collisions")
@export var regular_hitbox: CollisionShape3D
@export var crouch_hitbox: CollisionShape3D

@export_group("Dash")
@onready var dash_time_timer = %DashTimer
@onready var dash_cooldown_timer = %DashCooldown

@export_category("Crouch")

@export var crouch_check: ShapeCast3D
@export var crouch_offset: float = 0
@export var crouch_descent_speed: float = 3

@export_category("Jump")
@export var jump_vel: float = 5
@export var air_jump_count: int = 3

@export_category("Wall Interaction")

@export var wall_check: ShapeCast3D
@export var wall_descent_speed: float = -0.5
@export var gravity_modifier: float = 1
var is_wall_grabbed: bool = false


func _physics_process(delta: float) -> void:
	# Apply gravity when not on floor
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_modifier
	
	var speed_modifier = dash_modifier + crouch_modifier + slide_modifier
	speed = default_speed + speed_modifier
	
	# Get input direction
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	var curr_velocity = Vector2(movement_velocity.x, movement_velocity.z)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Handle movement
	if direction:
		curr_velocity = lerp(curr_velocity, Vector2(direction.x, direction.z) * speed, acceleration)
	else:
		curr_velocity = curr_velocity.move_toward(Vector2.ZERO, deceleration)
	
	# Update movement velocity (preserve Y component for gravity)
	movement_velocity = Vector3(curr_velocity.x, velocity.y, curr_velocity.y)
	
	# Apply the movement
	velocity = movement_velocity
	move_and_slide()

func update_rotation(rotation_input) -> void:
	global_transform.basis = Basis.from_euler(rotation_input)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
		
func dash():
	if not dash_cooldown_timer.time_left > 0:
		dash_modifier = dash_speed
	else:
		pass
	
func walk():
	dash_modifier = 0
	
func crouch():
	crouch_modifier = crouch_speed
	regular_hitbox.disabled = true
	crouch_hitbox.disabled = false
	
func slide():
	slide_modifier = slide_speed
	regular_hitbox.disabled = true
	crouch_hitbox.disabled = false
	
func uncrouch():
	crouch_modifier = 0
	slide_modifier = 0
	regular_hitbox.disabled = false
	crouch_hitbox.disabled = true
	
func jump():
	velocity.y += jump_vel

func wallgrab():
	velocity.y = wall_descent_speed

	
func wallungrab():
	is_wall_grabbed = false

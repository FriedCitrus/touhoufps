class_name SlidePlayerState

extends PlayerMovementState

@export var SPEED = 12
@export var ACCEL = 0.2
@export var DECEL = 1
@export var TILT: float = 0.09
@export_range(1,6,0.1) var ANIM_SPEED: float = 6

@onready var SHAPECAST: ShapeCast3D = %ShapeCast3D

func enter(previous_state) -> void:
	set_tilt(PLAYER.current_rotation)
	ANIMATION.get_animation("slide").track_set_key_value(6,0,PLAYER.velocity.length())
	ANIMATION.speed_scale = 1
	ANIMATION.play("slide", -1, ANIM_SPEED)
	
func exit() -> void:
	ANIMATION.speed_scale = 1

func update(delta) -> void:
	PLAYER.update_gravity(delta)
	#PLAYER.update_input(SPEED, ACCEL)
	PLAYER.update_velocity()
	
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")
	
	if PLAYER.velocity.y < -3 and !PLAYER.is_on_floor():
		transition.emit("FallPlayerState")

func set_tilt(player_rotation) -> void:
	var tilt = Vector3.ZERO
	tilt.z = clamp(TILT * player_rotation, -0.1, 0.1)
	if tilt.z == 0:
		tilt.z = 0.05
	ANIMATION.get_animation("slide").track_set_key_value(3,1, tilt)
	ANIMATION.get_animation("slide").track_set_key_value(3,2, tilt)
	

func finish():
	transition.emit("CrouchPlayerState")

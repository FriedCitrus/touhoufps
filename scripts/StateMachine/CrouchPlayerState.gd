class_name CrouchPlayerState extends PlayerMovementState

@export var SPEED: float = 5
@export var ACCEL: float = 0.1
@export var DECEL: float = 0.5
@export_range(1,6,0.1) var CROUCH_SPEED: float = 4

@onready var CROUCH_SHAPECAST: ShapeCast3D = %ShapeCast3D

var released: bool = false

func enter(previous_state) -> void:
	ANIMATION.speed_scale = 1
	if previous_state.name != "SlidePlayerState":
		ANIMATION.play("crouch", -1, CROUCH_SPEED)
	elif previous_state.name == "SlidePlayerState":
		ANIMATION.current_animation = "crouch"
		ANIMATION.seek(1,true)
		
func exit() -> void:
	released = false
	
func update(delta) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCEL)
	PLAYER.update_velocity()
	
	if Input.is_action_just_released("crouch"):
		uncrouch()
	elif Input.is_action_pressed("crouch") == false and released == false:
		released = true
		uncrouch()
		
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")

func uncrouch() -> void:
	if CROUCH_SHAPECAST.is_colliding() == false and Input.is_action_just_pressed("crouch") == false:
		ANIMATION.play("crouch", -1, -CROUCH_SPEED, true)
		if ANIMATION.is_playing():
			await ANIMATION.animation_finished
		transition.emit("IdlePlayerState")
	elif CROUCH_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()

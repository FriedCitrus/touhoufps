class_name WalkPlayerState

extends PlayerMovementState

@export var SPEED = 8
@export var ACCEL = 0.2
@export var DECEL = 1

func enter(previous_state) -> void:
	ANIMATION.pause()
	
func exit() -> void:
	ANIMATION.speed_scale = 1

func update(delta) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCEL)
	PLAYER.update_velocity()
	
	if Gloabal.player.velocity.length() == 0:
		transition.emit("IdlePlayerState")
	
	if Input.is_action_just_pressed("crouch"):
		transition.emit("SlidePlayerState")
		
	if PLAYER.velocity.y < -3 and !PLAYER.is_on_floor():
		transition.emit("FallPlayerState")
	
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")

class_name IdlePlayerState

extends PlayerMovementState

@export var SPEED = 8
@export var ACCEL = 0.2



func update(delta) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCEL)
	PLAYER.update_velocity()
	
	if Gloabal.player.velocity.length() > 0 and Gloabal.player.is_on_floor():
		transition.emit("WalkPlayerState")
	
	if Input.is_action_just_pressed("crouch"):
		transition.emit("CrouchPlayerState")
	
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")
		
	if PLAYER.velocity.y < -3 and !PLAYER.is_on_floor():
		transition.emit("FallPlayerState")

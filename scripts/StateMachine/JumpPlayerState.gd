class_name JumpPlayerState extends PlayerMovementState

@export var SPEED = 8
@export var ACCEL = 0.2
@export var DECEL = 1
@export var JUMP_VEL = 10
@export_range(1,6,0.1) var INPUT_MULTI = 0.85

func enter(previous_state) -> void:
	PLAYER.velocity.y += JUMP_VEL

	

func update(delta) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED * INPUT_MULTI, ACCEL)
	PLAYER.update_velocity()
	
	if PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
	
	if Input.is_action_just_pressed("crouch") and (PLAYER.velocity.x > 0 or PLAYER.velocity.z>0):
		transition.emit("SlidePlayerState")
	elif Input.is_action_just_pressed("crouch"):
		transition.emit("CrouchPlayerState")

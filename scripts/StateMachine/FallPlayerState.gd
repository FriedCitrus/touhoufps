class_name FallPlayerState extends PlayerMovementState

@export var SPEED = 8
@export var ACCEL = 0.2
@export var DECEL = 1
@export var JUMP_VEL = 10
@export_range(1,6,0.1) var INPUT_MULTI = 0.85


func update(delta) -> void:
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCEL)
	PLAYER.update_velocity()
	
	if PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
	

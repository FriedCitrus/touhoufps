class_name PlayerMovementState

extends State

var PLAYER: Player
@export var ANIMATION: AnimationPlayer
func _ready() -> void:
	await owner.ready
	PLAYER = owner as Player
	pass
	
func _process(delta: float) -> void:
	pass

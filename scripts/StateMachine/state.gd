class_name State

extends Node

var player : Player
var camera : CameraControl

@onready var dash_timer = %DashTimer
@onready var cooldown_timer = %DashCooldown

func _ready() -> void:
	if %StateMachine and %StateMachine is StateMachine:
		player = %StateMachine.player
		camera = %StateMachine.camera

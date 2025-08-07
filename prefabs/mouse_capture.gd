class_name MouseCapture extends Node

@export var debug: bool = false
@export_category("Mouse Capture Settings")
@export var curr_mouse_mode: Input.MouseMode = Input.MOUSE_MODE_CAPTURED
@export var mouse_sens = 0.005

var capture_mouse: bool
var mouse_inp: Vector2

func _unhandled_input(event: InputEvent) -> void:
	capture_mouse = event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	if capture_mouse: 
		mouse_inp.x = -event.screen_relative.x * mouse_sens
		mouse_inp.y = -event.screen_relative.y * mouse_sens
	if debug:
		print(mouse_inp)
		
func _ready() -> void:
	Input.mouse_mode = curr_mouse_mode
	
func _process(delta: float) -> void:
	mouse_inp = Vector2.ZERO

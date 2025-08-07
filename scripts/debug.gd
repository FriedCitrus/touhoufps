extends PanelContainer

var property
var fps: String

func _ready() -> void:
	Gloabal.debug = self
	visible = false


func _input(event) -> void:
	if event.is_action_pressed("debug"):
		visible = !visible

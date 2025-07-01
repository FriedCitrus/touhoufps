extends PanelContainer

@onready var prop_container = %VertBoxCont

var property
var fps: String

func _ready() -> void:
	Gloabal.debug = self
	visible = false
	add_prop("FPS",fps,4)


func _input(event) -> void:
	if event.is_action_pressed("debug"):
		visible = !visible
		
func _process(delta: float) -> void:
	if visible:
		fps = "%.2f" % (1/delta)

func add_prop(title:String,value,order):
	var target
	target = prop_container.find_child(title,true,false)
	if !target:
		target = Label.new()
		prop_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		prop_container.move_child(target, order)

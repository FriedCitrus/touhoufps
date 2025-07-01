extends CenterContainer

@export var dot_radius: float = 2.0
@export var dot_color: Color = Color.WHITE

func _ready() -> void:
	queue_redraw()
	pass

func _process(delta: float) -> void:
	pass
	
func _draw() -> void:
	draw_circle(Vector2(0,0), dot_radius, dot_color)

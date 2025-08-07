extends RayCast3D

var curr_object

func _process(delta: float) -> void:
	
	if is_colliding():
		var object = get_collider()
		if object == curr_object:
			return
		else:
			curr_object = object
	else:
		curr_object = null

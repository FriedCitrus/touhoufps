extends State

func _on_uncrouch_state_physics_processing(delta: float) -> void:
	camera.update_camera_height(delta, 1)
	
	if Input.is_action_pressed("crouch") and player.is_on_floor() and player.input_dir.length() == 0:
		player.state_chart.send_event("onCrouch")
		


func _on_uncrouch_state_entered() -> void:
	player.uncrouch()

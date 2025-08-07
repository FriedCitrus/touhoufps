extends State

func _on_crouch_state_physics_processing(delta: float) -> void:
	camera.update_camera_height(delta, -1)
	
	if not Input.is_action_pressed("crouch") and player.is_on_floor() and not player.crouch_check.is_colliding():
		player.state_chart.send_event("onUncrouch")


func _on_crouch_state_entered() -> void:
	player.crouch()

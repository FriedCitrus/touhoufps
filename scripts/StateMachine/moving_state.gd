extends State

func _on_moving_state_physics_processing(delta: float) -> void:
	if player.input_dir.length() == 0 and player.velocity.length() < 0.2:
		player.state_chart.send_event("onIdle") 
	if Input.is_action_pressed("crouch") and player.velocity.length() > 5.5:
		player.state_chart.send_event("onSlide")

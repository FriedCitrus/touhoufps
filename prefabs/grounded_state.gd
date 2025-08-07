extends State

func _on_grounded_state_physics_processing(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.jump()
		player.state_chart.send_event("onAirborne")
	if not player.is_on_floor():
		player.state_chart.send_event("onAirborne")
	
	if Input.is_action_just_pressed("dash"):
		player.dash()
		dash_timer.start()
		player.state_chart.send_event("onDash")

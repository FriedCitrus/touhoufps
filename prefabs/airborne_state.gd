extends State

func _on_airborne_state_physics_processing(delta: float) -> void:
	if player.is_on_floor():
		player.state_chart.send_event("onGrounded")
	if Input.is_action_just_pressed("dash") and not player.is_on_floor() and not cooldown_timer.time_left > 0:
		dash_timer.start()
		player.state_chart.send_event("onAirDash")

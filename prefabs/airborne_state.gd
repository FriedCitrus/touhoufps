extends State

func _on_airborne_state_physics_processing(delta: float) -> void:
	if player.is_on_floor():
		player.air_jump_count = 3
		player.state_chart.send_event("onGrounded")
		
	if Input.is_action_just_pressed("dash") and not player.is_on_floor() and not cooldown_timer.time_left > 0:
		player.dash()
		dash_timer.start()
		player.state_chart.send_event("onAirDash")
	elif Input.is_action_just_pressed("jump") and player.air_jump_count > 0:
		player.jump()
		player.air_jump_count -=1
		player.state_chart.send_event("onAirJump")
	elif Input.is_action_just_pressed("jump") and player.air_jump_count > 0 and player.wall_check.is_colliding():
		player.jump()
		player.air_jump_count -=1
		player.state_chart.send_event("onWallJump")
		await get_tree().create_timer(1).timeout
	elif player.wall_check.is_colliding():
		player.wallgrab()
		player.state_chart.send_event("onWallstick")
	

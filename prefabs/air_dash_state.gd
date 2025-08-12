extends State

func _on_air_dash_state_entered() -> void:
	print("dashed")
	player.dash()
	
func _on_dash_timer_timeout() -> void:
	print("timeout")
	player.dash_modifier = 0
	dash_timer.stop()
	cooldown_timer.start()
	if player.input_dir.length() > 0 and player.is_on_floor():
		player.state_chart.send_event("onWalk")
	elif player.is_on_floor():
		player.state_chart.send_event("onIdle")

func _on_dash_cooldown_timeout() -> void:
	cooldown_timer.stop()
	print("cooldown reset")

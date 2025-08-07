extends State
		
func _on_dash_state_entered() -> void:
	player.dash()

func _on_dash_timer_timeout() -> void:
	print("timeout")
	dash_timer.stop()
	cooldown_timer.start()
	if player and player.input_dir.length() > 0:
		player.state_chart.send_event("onWalk")
	else:
		player.state_chart.send_event("onIdle")

func _on_dash_cooldown_timeout() -> void:
	cooldown_timer.stop()
	print("cooldown reset")

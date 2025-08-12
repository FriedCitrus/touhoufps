extends State

func _on_walk_state_processing(delta: float) -> void:
	if Input.is_action_just_pressed("dash") and not cooldown_timer.time_left > 0:
		player.state_chart.send_event("onDash") 
		
func _on_walk_state_entered() -> void:
	player.walk()

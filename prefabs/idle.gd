extends State


func _on_idle_state_input(event: InputEvent) -> void:
	if player and player.input_dir.length() > 0 and player.velocity.length() > 0.2:
		player.state_chart.send_event("onMoving")

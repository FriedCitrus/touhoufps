extends State


func _on_idle_state_input(event: InputEvent) -> void:
	if player and player.input_dir.length() > 0:
		player.state_chart.send_event("onMoving")

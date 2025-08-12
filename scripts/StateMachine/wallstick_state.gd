extends State

func _on_wallstick_state_entered() -> void:
	pass

func _on_wallstick_state_exited() -> void:
	player.wallungrab()

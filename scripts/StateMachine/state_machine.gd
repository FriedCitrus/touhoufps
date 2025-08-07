class_name StateMachine extends Node

@export var debug: bool = false
@export_category("References")
@export var player: Player
@export var camera: CameraControl

func _process(delta: float) -> void:
	if player:
		player.state_chart.set_expression_property("velocity", player.velocity.length())
		player.state_chart.set_expression_property("hitting head",player.crouch_check.is_colliding())
		player.state_chart.set_expression_property("FPS", Engine.get_frames_per_second())
		player.state_chart.set_expression_property("Looking At", player.interaction_cast.curr_object)
		player.state_chart.set_expression_property("Dash Timer", player.dash_time_timer.time_left)
		player.state_chart.set_expression_property("Dash Cooldown", player.dash_cooldown_timer.time_left)

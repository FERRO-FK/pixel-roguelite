extends Node2D

## Run loop placeholder. Later this owns seed, floor, rooms, and restart.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()

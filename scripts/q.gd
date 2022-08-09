extends Node

func get_p1():
	return get_node("/root/0/globals/p1")

func get_camera_2d() -> Camera2D:
	return get_node("/root/0/world/Camera2D") as Camera2D
	
func get_card_shop():
	return get_node("/root/0/canvas/card_shop")

func is_tap_event(event: InputEvent, pressed: bool=true):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed == pressed:
			return true
	return false

func get_global_mouse_position():
	return get_camera_2d().get_global_mouse_position()

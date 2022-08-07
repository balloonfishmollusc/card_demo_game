extends Node

func get_p1():
	return get_node("/root/0/globals/p1")
	
func get_card_shop():
	return get_node("/root/0/canvas/card_shop")
	
func is_tap_event(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			return true
	return false

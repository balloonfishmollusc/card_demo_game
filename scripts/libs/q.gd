extends Node

func get_p1() -> Player:
	return get_node("/root/0/globals/p1") as Player

func get_camera_2d() -> Camera2D:
	return get_node("/root/0/world/Camera2D") as Camera2D

func get_turn_based() -> TurnBasedDirector:
	return get_node("/root/0/globals/turn_based") as TurnBasedDirector
	
func get_info_panel():
	return get_node("/root/0/canvas/info_panel")

func is_tap_event(event: InputEvent, pressed: bool=true):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed == pressed:
			return true
	return false

func get_global_mouse_position():
	return get_camera_2d().get_global_mouse_position()
	
func get_world_map() -> WorldMap:
	return get_node("/root/0/world/map") as WorldMap
	
func get_world_ui():
	return get_node("/root/0/world/ui")


enum Terrain {
	FLATLANDS,	# 平原
	MOUNTAIN,	# 山地
	OCEAN,		# 海洋
	PORT,		# 港口
	RELIC,		# 遗迹
}

class GridData:
	var terrain
	var building
	var pos: Vector2
	var res_type	# "C", "B", "A", "S" decided by init res_num
	var res_num		# 0 for none, 40 for normal, 100 for high

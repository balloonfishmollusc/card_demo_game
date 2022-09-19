extends Node2D
class_name GridNode

var grid_pos: Vector2
var building setget set_building

var res_num: int = 0
var terrain: int = 0

var res_level: String

func set_building(obj):
	assert(building == null)
	building = obj
	building.position = Q.get_world_map().local2world(grid_pos)
	add_child(obj)

func _init(pos) -> void:
	self.grid_pos = pos
	self.name = str(pos)

func place_res_point(_terrain, _res_num):
	self.terrain = _terrain
	self.res_num = _res_num
	if res_num > 80:
		self.res_level = "S"
	elif res_num > 60:
		self.res_level = "A"
	elif res_num > 40:
		self.res_level = "B"
	else:
		self.res_level = "C"
	var res_obj: Node = load("res://prefabs/res_point.tscn").instance()
	res_obj.name = "Res (%s)" % self.res_level
	res_obj.position = Q.get_world_map().local2world(grid_pos)
	add_child(res_obj)
		

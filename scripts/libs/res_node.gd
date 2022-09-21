extends Node2D
class_name ResNode

export var terrain = Q.Terrain.FLATLANDS
export var visible_on_ready = false

# init on ready
var res_num: int
var grid_pos: Vector2
var res_level: String

var building setget set_building

func set_building(obj):
	assert(building == null)
	building = obj
	building.position = Vector2.ZERO
	add_child(obj)

func _ready() -> void:
	self.grid_pos = Q.get_world_map().world_to_map(position)
	self.position = Q.get_world_map().local2world(grid_pos)
	self.name = str(grid_pos)
	self.res_num = randi() % 90 + 10
	if res_num > 80:
		self.res_level = "S"
	elif res_num > 60:
		self.res_level = "A"
	elif res_num > 40:
		self.res_level = "B"
	else:
		self.res_level = "C"
	if not self.visible_on_ready:
		self.visible = false

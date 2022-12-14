extends TileMap
class_name WorldMap

onready var _data_node = get_node("/root/0/world/_data")

func get_res_node(grid_pos) -> ResNode:
	for c in _data_node.get_children():
		if c.name == str(grid_pos) and c.visible:
			return c
	return null
	
func enable_random_res_node():
	var children: Array = _data_node.get_children()
	children.shuffle()
	for c in children:
		if not c.visible:
			c.visible = true
			return
	print("所有节点都已探索完毕")

func local2world(grid_pos):
	return map_to_world(grid_pos) + cell_size*0.5

func place_building(obj: Node2D, grid_pos) -> bool:
	var node = get_res_node(grid_pos)
	if node == null:
		return false
	if node.building != null:
		var b: Building = node.building
		if b.name == obj.name and b.is_completed():
			b.level += 1
			b.progress.x = 0
			select_grid(grid_pos)
			return true
		else:
			print("cannot place building!!")
			return false
	node.building = obj
	select_grid(grid_pos)
	return true

onready var ui = Q.get_world_ui()
var curr_node: ResNode = null

func select_grid(grid_pos: Vector2):
	ui.enable_selection_indicator(grid_pos)
	curr_node = get_res_node(grid_pos)
	assert(curr_node != null)
	Q.get_info_panel().enable(curr_node)
	
func deselect_grid():
	ui.disable_selection_indicator()
	curr_node = null
	Q.get_info_panel().disable()
		
var _moving_camera = false
var _mouse_pos_last_frame: Vector2
onready var _camera_2d = Q.get_camera_2d()

func _process(delta: float) -> void:
	if not _moving_camera:
		return
	var _mouse_pos_this_frame = get_viewport().get_mouse_position()
	_camera_2d.position -= (_mouse_pos_this_frame - _mouse_pos_last_frame) * _camera_2d.zoom.x
	_mouse_pos_last_frame = _mouse_pos_this_frame

var _last_tap_time = 0
var _last_tap_pos = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if Q.is_tap_event(event, true):
		var curr_msecs = OS.get_system_time_msecs()
		var curr_elpased_msecs = curr_msecs - _last_tap_time
		var curr_mouse_motion: Vector2 = event.position - _last_tap_pos
		_last_tap_time = curr_msecs
		_last_tap_pos = event.position
		
		var grid_pos = world_to_map(Q.get_global_mouse_position())
		if get_res_node(grid_pos) != null:
			select_grid(grid_pos)
			return
		# deselect_grid()
		
		if curr_elpased_msecs < 250 and curr_mouse_motion.length() < 32:
			# double tap
			if not _camera_2d.is_busy():
				_camera_2d.toggle_zoom_mode()
			return

		if not _camera_2d.is_busy():
			_moving_camera = true
			_mouse_pos_last_frame = get_viewport().get_mouse_position()
		
	if Q.is_tap_event(event, false):
		_moving_camera = false

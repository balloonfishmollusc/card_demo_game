extends TileMap

class_name WorldMap

var _data = {}

func _ready() -> void:
	pass

func place_building(obj: Node2D, grid_pos) -> bool:
	if not (grid_pos in _data):
		return false
	obj.name = str(grid_pos) + " " + obj.name
	var dt: Q.GridData = _data[grid_pos]
	if dt.building != null:
		var b: Building = dt.building
		if b.name == obj.name and b.is_completed():
			b.level += 1
			select_grid(grid_pos)
			return true
		else:
			print("cannot place building!!")
			return false
	get_node("/root/0/world/_data").add_child(obj)
	obj.position = map_to_world(grid_pos) + cell_size*0.5
	_data[grid_pos].building = obj
	select_grid(grid_pos)
	return true

onready var ui = Q.get_world_ui()
var curr_grid: Q.GridData = null

func select_grid(grid_pos: Vector2):
	if not (grid_pos in _data):
		return
	ui.enable_selection_indicator(grid_pos)
	curr_grid = _data[grid_pos]
	Q.get_info_panel().enable(curr_grid)
		
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
		select_grid(grid_pos)

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

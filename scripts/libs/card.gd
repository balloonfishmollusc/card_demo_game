extends Button

class_name Card

var on_drag: bool = false
var start_pos: Vector2
onready var ui = get_tree().root.get_node("0/world/ui")

export var invocable: bool = true

func _ready() -> void:
	connect("button_down", self, "_on_card_button_down")
	connect("button_up", self, "_on_card_button_up")

func _on_card_button_down() -> void:
	start_pos = self.rect_global_position

func _on_card_button_up() -> void:
	if not on_drag:
		return
	on_drag = false
	self.rect_global_position = start_pos
	self.modulate.a = 1.0
	var end_grid_pos = ui.disable_tile_indicator()
	_on_invoke(end_grid_pos)
	
func _on_invoke(grid_pos):
	print("card invocation!", grid_pos)
	
func _process(delta: float) -> void:
	if not on_drag:
		return
	var offset = self.rect_size * 0.5
	set_global_position(get_global_mouse_position()-offset)
	
	var container = get_parent() as HBoxContainer
	# 判断出卡区域
	var _can_use = get_global_mouse_position().y < container.rect_position.y

	if _can_use:
		ui.enable_tile_indicator(
			Q.get_global_mouse_position()-offset*Q.get_camera_2d().zoom.x
		)
		self.modulate.a = 0.5
	else:
		self.modulate.a = 1.0
		ui.disable_tile_indicator()

func get_drag_data(position: Vector2):
	if not invocable:
		return
	on_drag = true

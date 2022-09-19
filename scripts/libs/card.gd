extends Button

class_name Card

export(int) var price = 0
export(int) var cost = 0
export(String) var description = ""

var on_drag: bool = false
var start_pos: Vector2
onready var ui = get_tree().root.get_node("0/world/ui")

func _get_json_desc() -> Dictionary:
	return {
		"name": self.name,
		"price": self.price,
		"cost": self.cost
	}

func _ready() -> void:
	connect("button_down", self, "_on_card_button_down")
	connect("button_up", self, "_on_card_button_up")
	
	$data_label.text = JSON.print(_get_json_desc(), " ")

func _on_card_button_down() -> void:
	start_pos = self.rect_global_position

func _on_card_button_up() -> void:
	if not on_drag:
		return
	on_drag = false
	self.rect_global_position = start_pos
	self.modulate.a = 1.0
	var end_grid_pos = ui.disable_tile_indicator()
	if _can_use():
		if _on_invoke(end_grid_pos):
			Q.get_p1().cowries -= price
			Q.get_p1().energy -= cost
			self.delete()
		
func delete():
	self.name = '_'
	self.queue_free()
	
func _on_invoke(grid_pos):
	print("card invocation!", grid_pos)

func _can_use() -> bool:
	var container = get_parent().get_parent() as HBoxContainer
	return get_global_mouse_position().y < container.rect_position.y

func _process(delta: float) -> void:
	if not on_drag:
		return
	var offset = self.rect_size * 0.5
	set_global_position(get_global_mouse_position()-offset)

	if _can_use():
		var w_pos = Q.get_global_mouse_position()-offset*Q.get_camera_2d().zoom.x
		ui.enable_tile_indicator(Q.get_world_map().world_to_map(w_pos))
		self.modulate.a = 0.5
	else:
		self.modulate.a = 1.0
		ui.disable_tile_indicator()

func get_drag_data(position: Vector2):
	on_drag = true

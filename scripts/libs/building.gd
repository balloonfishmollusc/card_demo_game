extends Node2D
class_name Building

signal completed()
signal progress_changed(value)

var progress = Vector2(0, 3)	# 进度/最大进度
var level: int = 0				# 默认0级，建造完为1级
var working_rounds: int = 0		# 已经工作的回合数
onready var map = Q.get_world_map()

func get_grid_pos() -> Vector2:
	return map.world_to_map(self.position)

func get_terrain():
	return map._data[get_grid_pos()].terrain
	
func is_completed() -> bool:
	return progress.x >= progress.y

func _ready():
	var turn_based = Q.get_turn_based()
	turn_based.connect("round_started", self, "_on_round_start_internal")
	turn_based.connect("round_ended", self, "_on_round_end_internal")

func add_progress(inc: int):
	assert(not is_completed())
	progress.x = min(progress.x+inc, progress.y)
	emit_signal("progress_changed", progress)
	if is_completed():
		level += 1
		emit_signal("completed")
	
func _on_round_start_internal(i):
	if not is_completed():
		add_progress(1)

func _on_round_end_internal(i):
	if is_completed():
		_on_round_end(i)
		working_rounds += 1

func _on_round_end(i):
	pass
	
func get_desc():
	return name + " Lv. %d" % level + " Prog %d/%d" % [progress.x, progress.y]

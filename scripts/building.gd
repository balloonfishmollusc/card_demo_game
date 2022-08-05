extends Node2D
class_name Building

signal completed()
signal progress_changed(value)

var progress: Vector2	# 进度/最大进度
var level: int = 0		# 默认0级，建造完为1级

func is_completed() -> bool:
	return progress.x >= progress.y

func _ready():
	var turn_based = get_tree().root.get_node("0/globals/turn_based")
	turn_based.connect("round_started", self, "_on_round_start_internal")
	turn_based.connect("round_ended", self, "_on_round_end_internal")
	
func add_progress(inc: int):
	assert(not is_completed())
	progress.x = min(progress.x+inc, progress.y)
	emit_signal("progress_changed", progress)
	if is_completed():
		level += 1
		progress.x = 0
		emit_signal("completed")
	
func _on_round_start_internal(i):
	if not is_completed():
		add_progress(1)
	else:
		_on_round_start(i)

func _on_round_end_internal(i):
	if not is_completed():
		add_progress(1)
	else:
		_on_round_end(i)

func _on_round_start(i):
	pass
	
func _on_round_end(i):
	pass

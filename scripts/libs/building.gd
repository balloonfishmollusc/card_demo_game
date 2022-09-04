extends Node2D
class_name Building

signal completed()
signal progress_changed(value)

enum Terrain {
	FLATLANDS,	# 平原
	MOUNTAIN,	# 山地
	OCEAN,		# 海洋
	PORT,		# 港口
	DESERT,		# 沙漠
	UNKNOWN		# 未知	
}

var progress = Vector2(0, 3)	# 进度/最大进度
var level: int = 0				# 默认0级，建造完为1级
var working_rounds: int = 0		# 已经工作的回合数
var _terrain = Terrain.UNKNOWN

func get_terrain():
	if _terrain == Terrain.UNKNOWN:
		_terrain = Terrain.values()[randi() % Terrain.size()]
	return _terrain
	
func is_completed() -> bool:
	return progress.x >= progress.y

func _ready():
	var turn_based = Q.get_turn_based()
	turn_based.connect("round_started", self, "_on_round_start_internal")
	turn_based.connect("round_ended", self, "_on_round_end_internal")

func reset_progress():
	progress.x = 0
	emit_signal("progress_changed", progress)

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

func _on_select():
	Q.get_info_panel().enable(self)
	
func _on_deselect():
	Q.get_info_panel().disable()
	
func get_description():
	var info = name + " Lv. %d" % level + " Prog %d/%d" % [progress.x, progress.y]
	return info + '\n' + Terrain.keys()[get_terrain()]

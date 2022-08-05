extends Node2D

class_name Building

var progress: Vector2	# 进度/最大进度
var level: int = 0		# 默认0级，建造完为1级

var turn_based: TurnBasedDirector

func is_active() -> bool:
	"""已建造/升级完成"""
	return progress.x >= progress.y

func _ready():
	turn_based = get_tree().root.get_node("0/globals/turn_based")
	turn_based.connect("round_started", self, "on_round_start")
	turn_based.connect("round_ended", self, "on_round_end")
	
func on_round_start(i):
	pass
	
func on_round_end(i):
	pass

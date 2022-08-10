extends Control
class_name ResLabel

func _get_value():
	pass

var round_delta: int = 0
var val_on_pre_end = null

func _ready() -> void:
	var turn_based = Q.get_turn_based()
	turn_based.connect("pre_round_started", self, "on_pre_round_started")
	turn_based.connect("pre_round_ended", self, "on_pre_round_ended")

func _process(delta: float) -> void:
	$label.text = str(_get_value()) + " (%+d)" % round_delta

func on_pre_round_started(i):
	if val_on_pre_end == null:
		return
	round_delta = _get_value() - val_on_pre_end
	
func on_pre_round_ended(i):
	val_on_pre_end = _get_value()

extends Node

class_name TurnBasedDirector

signal round_started(i)
signal round_ended(i)

export var players: Array = []
var p_index: int = 0
var r_index: int = 0
var is_playing: bool = false

func _ready() -> void:
	for i in range(len(players)):
		players[i] = get_node(players[i])

func get_curr_player():
	return players[p_index]
	
func play():
	if len(players) < 1:
		push_error("TurnBasedDirector: players.Count < 1")
	is_playing = true
	
	r_index = 0;
	p_index = 0;

	while not is_game_end():
		r_index += 1;
		emit_signal("round_started", r_index)
		for p in players:
			p.state = TurnBasedPlayer.State.Ready
		for p in players:
			p.state = TurnBasedPlayer.State.Pending
			yield(p, "turn_submitted")
		emit_signal("round_ended", r_index)
	
func is_game_end() -> bool:
	return false

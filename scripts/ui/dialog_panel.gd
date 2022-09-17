extends Control
class_name DialogPanel

onready var text_box = $text_box
onready var avatar = $avatar

const TYPEWRITER_SPEED = 24

signal any_clicked()

func show_text(s: String):
	assert(not $Tween.is_active())
	
	visible = true
	text_box.visible_characters = 0
	text_box.text = s
	$Tween.interpolate_property(
		text_box,
		"visible_characters",
		0, len(s),
		len(s)*1.0 / TYPEWRITER_SPEED
	)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	
func show_choices():
	visible = true
	
func _input(event: InputEvent) -> void:
	if Q.is_tap_event(event):
		_on_any_click()
		
func _on_any_click():
	emit_signal("any_clicked")
	
func play(texts: Array):
	visible = true
	for t in texts:
		yield(self.show_text(t), "completed")
		yield(self, "any_clicked")
	visible = false
	

	


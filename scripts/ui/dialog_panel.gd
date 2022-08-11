extends Panel
class_name DialogPanel

onready var text_box = $text_box
onready var avatar = $avatar

const TYPEWRITER_SPEED = 8

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
	


extends Node

class_name Story

func pipeline(view: DialogPanel):
	yield(view.show_text("1234567891234567894"), "completed")
	yield(view.show_text("asdasdasdasdasdasd"), "completed")
	yield(view.show_text("asdasdasdasdasdasd"), "completed")







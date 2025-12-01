class_name attackdata
extends RichTextLabel

var default_text = "Attack Type: "
var value = " "

func _process(delta: float) -> void:
	var text = str(default_text, str (value))
	self.text = (text)

extends  attackdata

func _process(delta: float) -> void:
	default_text = "Frames: "
	var text = str(default_text, str (value))
	self.text = (text)

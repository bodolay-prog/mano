extends Control

@export var max_history_size: int = 16
var input_history: Array[String] = []

func _unhandled_input(event: InputEvent) -> void:
	var inputs = get_current_inputs()
	for input in inputs:
		add_input_to_history(input)

func get_current_inputs() -> Array[String]:
	var result: Array[String] = []
	var hori := 0
	var vert := 0
	
	# Botões
	if Input.is_action_just_pressed("p1_L"):
		result.append("L")
	if Input.is_action_just_pressed("p1_M"):
		result.append("M")
	if Input.is_action_just_pressed("p1_H"):
		result.append("H")
	if Input.is_action_just_pressed("p1_S"):
		result.append("S")
	if Input.is_action_just_pressed("p1_dash"):
		result.append("D")
		
	# Direções horizontais
	if (Input.is_action_pressed("p1_left") and Input.is_action_pressed("p1_right")) \
	or (not Input.is_action_pressed("p1_left") and not Input.is_action_pressed("p1_right")):
		hori = 0
	elif Input.is_action_pressed("p1_left"):
		hori = -1
	elif Input.is_action_pressed("p1_right"):
		hori = 1

	# Direções verticais
	if (Input.is_action_pressed("p1_up") and Input.is_action_pressed("p1_down")) \
	or (not Input.is_action_pressed("p1_up") and not Input.is_action_pressed("p1_down")):
		vert = 0
	elif Input.is_action_pressed("p1_down"):
		vert = -1
	elif Input.is_action_pressed("p1_up"):
		vert = 1

	# Converte direção numérica (1–9) pra string
	result.append(str(hori + 2 + ((vert + 1) * 3)))

	return result
	

func add_input_to_history(input: String) -> void:
	input_history.push_front(input)
	if input_history.size() > max_history_size:
		input_history.pop_back()
	update_display()

func update_display() -> void:
	var vbox = $VBoxContainer
	for child in vbox.get_children():
		child.queue_free()

	for input in input_history:
		var hbox = HBoxContainer.new()

		if input in ["1","2","3","4","5","6","7","8","9","L","M","H","S","D"]:
			var tex = TextureRect.new()
			tex.texture = load(get_arrow_path(input))
			tex.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			tex.set_custom_minimum_size(Vector2(16, 16))
			hbox.add_child(tex)
		else:
			var label = Label.new()
			label.text = input
			hbox.add_child(label)

		if input != "5":
			vbox.add_child(hbox)

func get_arrow_path(symbol: String) -> String:
	match symbol:
		"1": return "res://assets/icons/inputs_icons/1.png"
		"2": return "res://assets/icons/inputs_icons/2.png"
		"3": return "res://assets/icons/inputs_icons/3.png"
		"4": return "res://assets/icons/inputs_icons/4.png"
		"5": return "res://assets/icons/inputs_icons/5.png"
		"6": return "res://assets/icons/inputs_icons/6.png"
		"7": return "res://assets/icons/inputs_icons/7.png"
		"8": return "res://assets/icons/inputs_icons/8.png"
		"9": return "res://assets/icons/inputs_icons/9.png"
		"L": return "res://assets/icons/inputs_icons/L.png"
		"M": return "res://assets/icons/inputs_icons/M.png"
		"H": return "res://assets/icons/inputs_icons/H.png"
		"S": return "res://assets/icons/inputs_icons/S.png"
		"D": return "res://assets/icons/inputs_icons/D.png"
		_: return ""

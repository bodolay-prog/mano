extends Node
"""
Input Manager completo (com suporte a motions + botões + buffer).
Detecta:
- Direções 1..9 (com buffer de 48 frames)
- Motions (Hadouken, DP, 360, etc.)
- Botões (L, M, H, Special, Dash, etc.)
- Combinações (ex: Hadouken + L)
"""

# ====== Sinal de Motion ======
signal motion_perfomed(motion_name, button)

# ======= Configurações =======
const BUFFER_SIZE : int = 48
const DEBUG_PRINT : bool = true

# ======= Enums =======
enum MatchMode { STRICT, FUZZY }

# ======= Estado e Buffer =======
var dir_buffer : Array = []
var dir : int = 5
var hori : int = 0
var vert : int = 0
var facing : int = 1
var motions : Array = []

# === Referência ao Player ===
@onready
var p1 : P1Character = $".."

# ======= Inicialização =======
func _ready() -> void:
	_init_buffer()
	_register_example_motions()
	if DEBUG_PRINT:
		print("InputManager ready. Buffer size:", BUFFER_SIZE)

func _init_buffer() -> void:
	dir_buffer.clear()
	for i in range(BUFFER_SIZE):
		dir_buffer.append(5)

# ======= Atualização por frame =======
func _physics_process(delta: float) -> void:
	#_debug_print()
	if p1.on_right_side:
		facing = -1
	else:
		facing =  1
		
	dir = _maybe_mirror_dir(movement_inputs())
	_push_direction(_maybe_mirror_dir(dir))

	var atk_input = action_inputs()
	if atk_input != "N":
		try_consume_motions(atk_input)

# ======= Leitura de Direcional (1..9) =======
func movement_inputs() -> int:
	if (Input.is_action_pressed("p1_left") and Input.is_action_pressed("p1_right")) \
	or (not Input.is_action_pressed("p1_left") and not Input.is_action_pressed("p1_right")):
		hori = 0
	elif Input.is_action_pressed("p1_left"):
		hori = -1
	elif Input.is_action_pressed("p1_right"):
		hori = 1

	if (Input.is_action_pressed("p1_up") and Input.is_action_pressed("p1_down")) \
	or (not Input.is_action_pressed("p1_up") and not Input.is_action_pressed("p1_down")):
		vert = 0
	elif Input.is_action_pressed("p1_down"):
		vert = -1
	elif Input.is_action_pressed("p1_up"):
		vert = 1

	return hori + 2 + ((vert + 1) * 3)

# ======= Leitura de Botões =======
# Retorna o botão apertado no frame (ou "N" se nenhum)
func action_inputs() -> String:
	
	if Input.is_action_just_pressed("p1_L"):
		return "L"
	if Input.is_action_just_pressed("p1_M"):
		return "M"
	if Input.is_action_just_pressed("p1_H"):
		return "H"
	if Input.is_action_just_pressed("p1_S"): # botão de especial
		return "S"
		
	if Input.is_action_just_pressed("p1_dash"):
		return "dash"
	return "N"

# ======= Funções do Buffer =======
func _push_direction(d: int) -> void:
	dir_buffer.pop_back()
	dir_buffer.insert(0, d)

func get_buffer_snapshot() -> Array:
	return dir_buffer.duplicate()

# ======= Classe de Motion =======
class InputMotion:
	var name : String
	var steps : Array

	func _init(_name: String = ""):
		name = _name
		steps = []

	func add_step(_dir: int, _window: int, _mode: int = MatchMode.STRICT) -> void:
		steps.append({ "dir": _dir, "window": _window, "mode": _mode })

# ======= Registro de Motions =======
func _register_example_motions() -> void:
	
	var had = InputMotion.new("hadouken")
	had.add_step(2, 8, MatchMode.FUZZY)
	had.add_step(3, 6, MatchMode.FUZZY)
	had.add_step(6, 4, MatchMode.STRICT)
	motions.append(had)
	
	var had2 = InputMotion.new("hadouken")
	had2.add_step(2, 12, MatchMode.STRICT)
	had2.add_step(6, 12, MatchMode.STRICT)
	motions.append(had2)
	
	var tsm = InputMotion.new("tatsumaki")
	tsm.add_step(2, 5, MatchMode.FUZZY)
	tsm.add_step(1, 4, MatchMode.FUZZY)
	tsm.add_step(4, 4, MatchMode.STRICT)
	motions.append(tsm)
	
	var tsm2 = InputMotion.new("tatsumaki")
	tsm2.add_step(2, 6, MatchMode.STRICT)
	tsm2.add_step(4, 6, MatchMode.STRICT)
	motions.append(tsm2)

	var srk = InputMotion.new("shoryuken")
	srk.add_step(6, 12, MatchMode.STRICT)
	srk.add_step(2, 8, MatchMode.FUZZY)
	srk.add_step(3, 8, MatchMode.FUZZY)
	motions.append(srk)
	
	var srk2 = InputMotion.new("shoryuken")
	srk2.add_step(6, 16, MatchMode.STRICT)
	srk2.add_step(2, 12, MatchMode.FUZZY)
	srk2.add_step(6, 12, MatchMode.STRICT)
	motions.append(srk2)

	var qcb = InputMotion.new("quarter_circle_back")
	qcb.add_step(6, 12, MatchMode.FUZZY)
	qcb.add_step(3, 10, MatchMode.FUZZY)
	qcb.add_step(2, 8, MatchMode.FUZZY)
	qcb.add_step(1, 6, MatchMode.FUZZY)
	qcb.add_step(4, 4, MatchMode.FUZZY)
	motions.append(qcb)
	
	var qcb2 = InputMotion.new("quarter_circle_back")
	qcb2.add_step(6, 16, MatchMode.STRICT)
	qcb2.add_step(1, 16, MatchMode.STRICT)
	qcb2.add_step(4, 16, MatchMode.STRICT)
	motions.append(qcb2)


# ======= Checagem de Motions =======
func check_motion(motion: InputMotion) -> bool:
	var buf = dir_buffer
	var steps = motion.steps.duplicate()
	var search_start : int = 0

	for i in range(steps.size() - 1, -1, -1):
		var entry = steps[i]
		var target_dir = entry["dir"]
		var window = entry["window"]
		var mode = entry["mode"]
		var effective_target = _maybe_mirror_dir(target_dir)

		var found_idx = -1
		var max_search = min(search_start + window, buf.size())
		for j in range(search_start, max_search):
			if _match_direction(buf[j], effective_target, mode):
				found_idx = j
				break
		if found_idx == -1:
			return false
		search_start = found_idx + 1
	return true

# ======= Detecta motions ao apertar botão =======
func try_consume_motions(button: String) -> void:
	for m in motions:
		if check_motion(m):
			_on_motion_detected(m, button)
			return

func _on_motion_detected(motion: InputMotion, button: String) -> void:
	if DEBUG_PRINT:
		print("Motion detected:", motion.name, " Botão:", button)
	# Aqui você pode emitir sinal ou chamar personagem:
	motion_perfomed.emit(motion.name, button)

# ======= Matching auxiliar =======
func _match_direction(current: int, target: int, mode: int) -> bool:
	if mode == MatchMode.STRICT:
		return current == target
	var adj = {
		1: [1,2,4], 2: [1,2,3], 3: [2,3,6],
		4: [1,4,7], 5: [5], 6: [3,6,9],
		7: [4,7,8], 8: [7,8,9], 9: [6,8,9]
	}
	return current in adj.get(target, [target])

# ======= Espelhamento =======
func _maybe_mirror_dir(d: int) -> int:
	if facing == 1:
		return d
	var mirror = {
		1: 3, 2: 2, 3: 1,
		4: 6, 5: 5, 6: 4,
		7: 9, 8: 8, 9: 7
	}
	return mirror.get(d, d)

# ======= Charge detection =======
func is_charge_held(direction: int, min_frames: int) -> bool:
	for i in range(min_frames):
		if i >= dir_buffer.size():
			return false
		if _maybe_mirror_dir(direction) != dir_buffer[i]:
			return false
	return true

# ======= Debug =======
func _debug_print() -> void:
	var brief = []
	for i in range(min(BUFFER_SIZE, 8)):
		brief.append(str(dir_buffer[i]))
	printt("DIR:", dir, " FACING:", facing, " BUFFER:", brief)

func printt(varargs) -> void:
	var s := ""
	for v in varargs:
		s += str(v) + " "
	print(s.strip_edges())

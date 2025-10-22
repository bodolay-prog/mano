extends Node
"""
Input manager completo para fighting-game style motions + input buffer.

Como usar:
- Anexe este script num Node (por ex. InputManager).
- No projeto, defina actions: p1_left, p1_right, p1_up, p1_down, p1_attack, p1_punch, etc.
- No _physics_process() o input é lido e empurrado pro buffer.
- Ao detectar Input.is_action_just_pressed("p1_punch") chamamos try_consume_motions().
"""

# ======= Configurações =======
const BUFFER_SIZE : int = 48  # quantos frames lembrar (ajuste conforme necessidade)
const DEBUG_PRINT : bool = true

# ======= Enums =======
enum MatchMode { STRICT, FUZZY }

# ======= Buffer & Estado =======
var dir_buffer : Array = []
var dir : int = 5
var hori : int = 0
var vert : int = 0

# Facing: 1 = virado para a direita (padrão), -1 = virado para a esquerda
var facing : int = 1

# Lista de motions registrados
var motions : Array = []

# ======= Inicialização =======
func _ready() -> void:
	_init_buffer()
	_register_example_motions()
	if DEBUG_PRINT:
		print("InputManager ready. Buffer size: ", BUFFER_SIZE)

func _init_buffer() -> void:
	dir_buffer.clear()
	for i in range(BUFFER_SIZE):
		dir_buffer.append(5)  # start neutral

# ======= Loop: atualiza inputs por frame =======
func _physics_process(delta: float) -> void:
	# 1) Ler direcional atual
	dir = movement_inputs()
	# 2) Empurrar pro buffer (mais recente em índice 0)
	_push_direction(dir)

	# 3) Debug opcional: print do dir e do buffer
	#if DEBUG_PRINT:
		#_debug_print()

	# 4) Exemplo de detecção: quando aperta p1_punch, tentamos detectar motions
	if Input.is_action_just_pressed("p1_L"):
		try_consume_motions("p1_L")

# ======= Input handler (retorna 1..9) =======
func movement_inputs() -> int:
	# Horizontal
	if (Input.is_action_pressed("p1_left") and Input.is_action_pressed("p1_right")) \
	   or (not Input.is_action_pressed("p1_left") and not Input.is_action_pressed("p1_right")):
		hori = 0
	elif Input.is_action_pressed("p1_left"):
		hori = -1
	elif Input.is_action_pressed("p1_right"):
		hori = 1

	# Vertical (note: up = -1, down = 1 para casar com numpad)
	if (Input.is_action_pressed("p1_up") and Input.is_action_pressed("p1_down")) \
	   or (not Input.is_action_pressed("p1_up") and not Input.is_action_pressed("p1_down")):
		vert = 0
	elif Input.is_action_pressed("p1_down"):
		vert = -1
	elif Input.is_action_pressed("p1_up"):
		vert = 1

	# Calcular dir 1..9
	return hori + 2 + ((vert + 1) * 3)

# ======= Buffer funcs =======
func _push_direction(d: int) -> void:
	# Remove último (mais antigo) e insere novo no começo (índice 0)
	dir_buffer.pop_back()
	dir_buffer.insert(0, d)

func get_buffer_snapshot() -> Array:
	# Cópia para leitura externa (0 = mais recente)
	return dir_buffer.duplicate()

# ======= InputMotion class-like simples =======
class InputMotion:
	var name : String
	var steps : Array  # cada step é { "dir": int, "window": int, "mode": MatchMode }

	func _init(_name: String = ""):
		name = _name
		steps = []

	func add_step(_dir: int, _window: int, _mode: int = MatchMode.STRICT) -> void:
		steps.append({ "dir": _dir, "window": _window, "mode": _mode })

# ======= Registra alguns motions de exemplo =======
func _register_example_motions() -> void:
	# Hadouken (QCF) tipicamente 2 -> 3 -> 6
	var had = InputMotion.new("hadouken")
	had.add_step(2, 8, MatchMode.FUZZY)   # allow some tolerance for the first
	had.add_step(3, 6, MatchMode.FUZZY)
	had.add_step(6, 4, MatchMode.STRICT)  # final should be strict
	motions.append(had)
	
	var had2 = InputMotion.new("hadouken2")
	had2.add_step(2, 8, MatchMode.STRICT)
	had2.add_step(6, 8, MatchMode.STRICT)
	motions.append(had2)
	
	var tsm = InputMotion.new("tatsumaki")
	tsm.add_step(2, 8, MatchMode.FUZZY)   
	tsm.add_step(1, 6, MatchMode.FUZZY)
	tsm.add_step(4, 4, MatchMode.STRICT)
	motions.append(tsm)
	
	var tsm2 = InputMotion.new("tatsumaki2")
	tsm2.add_step(2, 8, MatchMode.STRICT)   
	tsm2.add_step(4, 8, MatchMode.STRICT)
	motions.append(tsm2)
	
	# Shoryuken (DP) tipicamente 6 -> 2 -> 3 (forward DP on right-facing)
	var srk = InputMotion.new("shoryuken")
	srk.add_step(6, 8, MatchMode.STRICT)
	srk.add_step(3, 6, MatchMode.FUZZY)
	srk.add_step(2, 6, MatchMode.FUZZY)
	motions.append(srk)
	
	var srk2 = InputMotion.new("shoryuken2")
	srk2.add_step(6, 10, MatchMode.STRICT)
	srk2.add_step(2, 10, MatchMode.STRICT)
	srk2.add_step(6, 10, MatchMode.STRICT)
	motions.append(srk2)
	
	var qrtb = InputMotion.new("quarter circle back")
	qrtb.add_step(6, 20, MatchMode.FUZZY)
	qrtb.add_step(3, 20, MatchMode.FUZZY)
	qrtb.add_step(2, 16, MatchMode.FUZZY)
	qrtb.add_step(1, 12, MatchMode.FUZZY)
	qrtb.add_step(4, 12, MatchMode.FUZZY)
	motions.append(qrtb)
	
	var qrtb2 = InputMotion.new("quarter circle back2")
	qrtb2.add_step(6, 48, MatchMode.STRICT)
	qrtb2.add_step(2, 48, MatchMode.STRICT)
	qrtb2.add_step(4, 48, MatchMode.STRICT)
	motions.append(qrtb2)
	
	var qrtb3 = InputMotion.new("quarter circle back3")
	qrtb3.add_step(6, 18, MatchMode.FUZZY)
	qrtb3.add_step(3, 14, MatchMode.FUZZY)
	qrtb3.add_step(2, 12, MatchMode.FUZZY)
	qrtb3.add_step(1, 10, MatchMode.FUZZY)
	qrtb3.add_step(4, 6, MatchMode.FUZZY)
	motions.append(qrtb3)
	
	# 360 style (example simple, but real 360 needs circular logic)
	var spin = InputMotion.new("spin360_simple")
	spin.add_step(6, 6, MatchMode.FUZZY)
	spin.add_step(4, 6, MatchMode.FUZZY)
	spin.add_step(6, 6, MatchMode.FUZZY)
	motions.append(spin)
	
	var atk = InputMotion.new("attack")
	atk.add_step(5, 48, MatchMode.FUZZY)
	motions.append(atk)
# ======= Verificação de motion (reverse matching no buffer) =======
# Lógica: para um motion com steps [a,b,c], quando o botão é apertado
# procuramos c no buffer a partir do índice 0 (mais recente) até window_c,
# depois procuramos b a partir do índice do c+1 até window_b, etc.
func check_motion(motion: InputMotion) -> bool:
	var buf = dir_buffer
	# copiamos steps e iteramos do último passo para o primeiro
	var steps = motion.steps.duplicate()
	# passo final é o último em ordem normal; no array é steps[-1]
	var search_start : int = 0  # índice inicial de busca (0 = mais recente)
	# percorrer os passos de trás pra frente
	for i in range(steps.size() - 1, -1, -1):
		var entry = steps[i]
		var target_dir = entry["dir"]
		var window = entry["window"]
		var mode = entry["mode"]

		# se o personagem estiver virado à esquerda, espelhe o target
		var effective_target = _maybe_mirror_dir(target_dir)

		var found_idx = -1
		var max_search = min(search_start + window, buf.size())
		for j in range(search_start, max_search):
			if _match_direction(buf[j], effective_target, mode):
				found_idx = j
				break
		if found_idx == -1:
			# falhou em casar este passo -> motion inválido
			return false
		# o próximo passo anterior deve procurar a partir de found_idx + 1 (frames antes)
		search_start = found_idx + 1
		# continue com próximos passos
	return true

# ======= Consumir / executar motions ao apertar botão =======
# Ao detectar um input de ataque, chamamos esta função para testar motions definidos
func try_consume_motions(action_name: String) -> void:
	# ordem de prioridade: percorra motions em ordem (pode priorizar por dano / raridade)
	for m in motions:
		if check_motion(m):
			_on_motion_detected(m,action_name)
			return  # opcional: consome apenas o primeiro detectado

func _on_motion_detected(motion: InputMotion, action_name: String) -> void:
	# aqui você dispara a animação, aplica o consumo de barra, etc.
	if DEBUG_PRINT:
		print("Motion detected: ", motion.name, " botão: ", action_name)
	# exemplo: você pode emitir um sinal ou chamar o método do personagem
	# emit_signal("motion_performed", motion.name)

# ======= Matching util =======
func _match_direction(current: int, target: int, mode: int) -> bool:
	if mode == MatchMode.STRICT:
		return current == target
	# fuzzy: permite adjacentes (definimos map de adjacentes)
	var adj = {
		1: [1,2,4],
		2: [1,2,3],
		3: [2,3,6],
		4: [1,4,7],
		5: [5],
		6: [3,6,9],
		7: [4,7,8],
		8: [7,8,9],
		9: [6,8,9]
	}
	return current in adj.get(target, [target])

# ======= Espelhamento de direções baseado no facing =======
# Se facing == -1 (virado para esquerda), trocamos left<>right e diagonais accordingly.
func _maybe_mirror_dir(d: int) -> int:
	if facing == 1:
		return d
	# mapping mirror: 1<->3, 4<->6, 7<->9, 2 and 8 and 5 stay same
	var mirror = {
		1: 3, 2: 2, 3: 1,
		4: 6, 5: 5, 6: 4,
		7: 9, 8: 8, 9: 7
	}
	return mirror.get(d, d)

# ======= Charge detection simplificado =======
# Detecta se a direção foi segurada por ao menos min_frames consecutivos
func is_charge_held(direction: int, min_frames: int) -> bool:
	for i in range(min_frames):
		if i >= dir_buffer.size():
			return false
		if _maybe_mirror_dir(direction) != dir_buffer[i]:
			return false
	return true

# ======= Debug print =======
func _debug_print() -> void:
	# mostra dir atual e os primeiros 8 frames do buffer
	var brief = []
	for i in range(min(BUFFER_SIZE, 8)):
		brief.append(str(dir_buffer[i]))
	printt("DIR:", dir, " FACING:", facing, " BUFFER:", brief)

# Utilidade para print formatado (compatível Godot 4/5)
func printt(varargs) -> void:
	var s := ""
	for v in varargs:
		s += str(v) + " "
	print(s.strip_edges())

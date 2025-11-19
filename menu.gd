extends Control

var current_player: int = 1

# Ajuste os caminhos se necessário.
@onready var player_one_frame = get_node_or_null("Select/playerOne/ColorRect")
@onready var player_two_frame = get_node_or_null("Select/playerTwo/ColorRect")
@onready var player_two_node = get_node_or_null("Select/playerTwo")

# --- GRUPO PARA BOTÕES ---
# Lembre-se de adicionar todos os botões de personagem ao grupo "character_selection"
const CHARACTER_BUTTON_GROUP = "character_selection"


func _ready() -> void:
	# Correção: Verificar pelo nome correto do Autoload
	if Engine.has_singleton("GameState"):
		# Garante estado limpo, mas é redundante se o Control.gd funcionar corretamente
		# Deixamos como segurança.
		GameState.reset_characters() 
	else:
		printerr("Autoload 'GameState' não encontrado. Verifique Project > Project Settings > AutoLoad.")
	
	current_player = 1
	update_selection_ui()
	
	# Conecta a função de seleção a todos os botões do grupo
	for node in get_tree().get_nodes_in_group(CHARACTER_BUTTON_GROUP):
		if node is Button:
			node.pressed.connect(_on_character_button_pressed.bind(node.name))

# Função única para todos os botões de personagem
func _on_character_button_pressed(button_name: String) -> void:
	# Usamos o nome do botão como o nome do personagem. 
	# Ex: Botão chamado "Otavio" seleciona "Otavio".
	handle_selection(button_name)


func update_selection_ui() -> void:
	# 1. Zera ou configura cores/visibilidade
	
	# Checa e zera cores com segurança
	if player_one_frame:
		player_one_frame.modulate = Color.WHITE
	if player_two_frame:
		player_two_frame.modulate = Color.WHITE

	# Mostrar/Esconder P2 no modo Treinamento (IA)
	if player_two_node:
		# is_training_mode implica que não é 2P, e P2 deve ser escondido
		player_two_node.visible = not GameState.is_training_mode
	else:
		printerr("menu.gd: node 'playerTwo' não encontrado.")

	# 2. Destacar jogador atual
	if current_player == 1:
		if player_one_frame:
			player_one_frame.modulate = Color.YELLOW
	elif current_player == 2 and GameState.is_two_player:
		if player_two_frame:
			player_two_frame.modulate = Color.YELLOW
	
	# Se for modo treino, o P2 nunca precisa de destaque, pois é IA/Dummy.

func handle_selection(character_name: String) -> void:
	# 1. Grava escolha
	GameState.select_character(current_player, character_name)

	# 2. Transição de estado
	if GameState.is_two_player:
		if current_player == 1:
			current_player = 2
			update_selection_ui()
		else: # current_player == 2
			print("Seleção completa — iniciando luta 2P.")
			GameState.start_fight_scene()
	else:
		# Modo Treino/IA: P2 é sempre "Dummy" (ou outro nome predefinido)
		GameState.select_character(2, "Dummy")
		print("Seleção completa — iniciando treino.")
		GameState.start_fight_scene()


func _on_button_one_mouse_entered() -> void:
	get_node("Select/playerOne").color = Color.YELLOW

func _on_button_one_mouse_exited() -> void:
	get_node("Select/playerOne").color = Color.WHITE


func _on_button_two_mouse_entered() -> void:
	get_node("Select/playerTwo").color = Color.YELLOW


func _on_button_two_mouse_exited() -> void:
	get_node("Select/playerTwo").color = Color.WHITE

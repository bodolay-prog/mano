extends Control

var current_player: int = 1

# Ajuste os caminhos se necessário.
@onready var player_one_frame = get_node_or_null("Select/playerOne/ColorRect")
@onready var player_two_frame = get_node_or_null("Select/playerTwo/ColorRect")
@onready var player_two_node = get_node_or_null("Select/playerTwo")

# GRUPO PARA BOTÕES
const CHARACTER_BUTTON_GROUP = "character_selection"


func _ready() -> void:
	if Engine.has_singleton("GameState"):
		GameState.reset_characters()
	else:
		printerr("Autoload 'GameState' não encontrado. Verifique Project > Project Settings > AutoLoad.")
	
	current_player = 1
	update_selection_ui()
	
	for node in get_tree().get_nodes_in_group(CHARACTER_BUTTON_GROUP):
		if node is Button:
			node.pressed.connect(_on_character_button_pressed.bind(node.name))

# Função única para todos os botões de personagem
func _on_character_button_pressed(button_name: String) -> void:
	handle_selection(button_name)


func update_selection_ui() -> void:
	# Zera ou configura cores/visibilidade
	if player_one_frame:
		player_one_frame.modulate = Color.WHITE
	if player_two_frame:
		player_two_frame.modulate = Color.WHITE

	# Mostrar/Esconder P2 no modo Treinamento
	if player_two_node:
		player_two_node.visible = not GameState.is_training_mode
	else:
		printerr("menu.gd: node 'playerTwo' não encontrado.")

	# Destacar jogador atual
	if current_player == 1:
		if player_one_frame:
			player_one_frame.modulate = Color.YELLOW
	elif current_player == 2 and GameState.is_two_player:
		if player_two_frame:
			player_two_frame.modulate = Color.YELLOW

func handle_selection(character_name: String) -> void:
	# Grava escolha
	GameState.select_character(current_player, character_name)

	# Transição de estado
	if GameState.is_two_player:
		if current_player == 1:
			current_player = 2
			update_selection_ui()
		else: # current_player == 2
			print("Seleção completa — iniciando seleção de mapa 2P.")
			# VAI PARA A SELEÇÃO DE MAPA
			GameState.start_map_selection()
	else:
		# Modo Treino
		GameState.select_character(2, "Dummy")
		print("Seleção completa — iniciando seleção de mapa Treino.")
		# VAI PARA A SELEÇÃO DE MAPA
		GameState.start_map_selection()


# Funções de cor dos botoes
func _on_button_one_mouse_entered() -> void:
	get_node("Select/playerOne").color = Color.YELLOW

func _on_button_one_mouse_exited() -> void:
	get_node("Select/playerOne").color = Color.WHITE

func _on_button_two_mouse_entered() -> void:
	get_node("Select/playerTwo").color = Color.YELLOW

func _on_button_two_mouse_exited() -> void:
	get_node("Select/playerTwo").color = Color.WHITE

# menu.gd (cole este arquivo na cena de SELEÇÃO de personagem)
extends Control

var current_player: int = 1

# Ajuste os caminhos abaixo se a sua árvore for diferente.
# Recomendo substituir "playerOne/ColorRect" pelo Node Path copiado do editor, se necessário.
@onready var player_one_frame = get_node_or_null("playerOne/ColorRect")
@onready var player_two_frame = get_node_or_null("playerTwo/ColorRect")
@onready var player_two_node = get_node_or_null("playerTwo")

func _ready() -> void:
	current_player = 1
	# usa GameStatus (nome do seu autoload)
	if Engine.has_singleton("GameStatus"):
		GameState.reset_characters()
	else:
		printerr("Autoload 'GameStatus' não encontrado. Verifique Project > Project Settings > AutoLoad.")
	update_selection_ui()

func update_selection_ui() -> void:
	# Checa e zera cores com segurança
	if player_one_frame:
		player_one_frame.modulate = Color.WHITE
	else:
		printerr("menu.gd: player_one_frame é null. Verifique o path 'playerOne/ColorRect' e se o script está na cena certa.")

	if player_two_frame:
		player_two_frame.modulate = Color.WHITE
	else:
		# apenas log, não quebra
		# printerr("menu.gd: player_two_frame é null. Verifique o path 'playerTwo/ColorRect'.")
		pass

	# Mostrar/Esconder P2 no modo treino
	if GameState.is_training_mode:
		if player_two_node:
			player_two_node.visible = false
		else:
			printerr("menu.gd: node 'playerTwo' não encontrado ao tentar esconder P2.")
	else:
		if player_two_node:
			player_two_node.visible = true

	# Destacar jogador atual
	if current_player == 1:
		if player_one_frame:
			player_one_frame.modulate = Color.YELLOW
	elif current_player == 2 and GameState.is_two_player:
		if player_two_frame:
			player_two_frame.modulate = Color.YELLOW


func handle_selection(character_name: String) -> void:
	# grava escolha
	GameState.select_character(current_player, character_name)

	if GameState.is_two_player:
		if current_player == 1:
			current_player = 2
			update_selection_ui()
		else:
			print("Seleção completa — iniciando luta 2P.")
			GameState.start_fight_scene()
	else:
		# treino: define Dummy e inicia
		GameState.select_character(2, "Dummy")
		print("Seleção completa — iniciando treino.")
		GameState.start_fight_scene()


func _on_otavio_selected() -> void:
	handle_selection("Otavio")

func _on_cirineu_selected() -> void:
	handle_selection("Cirineu")


func _on_button_one_mouse_entered() -> void:
	get_node("Select/playerOne").color = Color.YELLOW


func _on_button_one_mouse_exited() -> void:
	get_node("Select/playerOne").color = Color.WHITE


func _on_button_two_mouse_entered() -> void:
	get_node("Select/playerTwo").color = Color.YELLOW

func _on_button_two_mouse_exited() -> void:
	get_node("Select/playerTwo").color = Color.WHITE

extends Control

var current_player: int = 1

#text
@onready var main_text: Label = $main_text

@onready var sfx: AudioStreamPlayer = $sfx

#color react
@onready var ken: ColorKen = $Select/playerOne
@onready var ryu: ColorRyu = $Select/playerTwo

#animaitons
@onready var animationsken_: AnimationPlayer = $Select/playerOne/animation
@onready var animationsryu_: AnimationPlayer = $Select/playerTwo/animation

#voice lines
@onready var vlken_: AudioStreamPlayer = $Select/playerOne/vl
@onready var vlryu_: AudioStreamPlayer = $Select/playerTwo/vl

var traning_stage_path = "res://main_fight_scenes/training/training_main.tscn"

# Ajuste os caminhos se necessário.
@onready var player_one_frame = get_node_or_null("Select/playerOne/ColorRect")
@onready var player_two_frame = get_node_or_null("Select/playerTwo/ColorRect")
@onready var player_two_node = get_node_or_null("Select/playerTwo")

# GRUPO PARA BOTÕES
const CHARACTER_BUTTON_GROUP = "character_selection"


func change_to(_path) -> void:
	get_tree().change_scene_to_file(_path)

func _ready() -> void:
	Bgm.play_music_level()
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
	
	if button_name == "Ryu":
		await animationsryu_.animation_finished
		await vlryu_.finished
		ryu.reset_ani()
	
	if button_name == "Ken":
		await animationsken_.animation_finished
		await vlken_.finished
		ken.reset_ani()
		
	handle_selection(button_name)
	

func _process(delta: float) -> void:
	
	if current_player == 1:
		main_text.text = "SELECIONHE O P1!"
	
	if current_player == 2:
		main_text.text = "SELECIONHE O P2!"

	

func update_selection_ui() -> void:
	# Zera ou configura cores/visibilidade
	if player_one_frame:
		player_one_frame.modulate = Color.WHITE
	if player_two_frame:
		player_two_frame.modulate = Color.WHITE

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
		GameState.select_character(2, "Ken")
		print("Seleção completa — iniciando seleção de mapa Treino.")
		# VAI PARA A SELEÇÃO DE MAPA
		Bgm.stop_music()
		change_to(traning_stage_path)
		


# Funções de cor dos botoes
func _on_button_one_mouse_entered() -> void:
	sfx.play()
	get_node("Select/playerOne").color = Color.YELLOW

func _on_button_one_mouse_exited() -> void:
	get_node("Select/playerOne").color = Color.WHITE

func _on_button_two_mouse_entered() -> void:
	sfx.play()
	get_node("Select/playerTwo").color = Color.YELLOW

func _on_button_two_mouse_exited() -> void:
	get_node("Select/playerTwo").color = Color.WHITE

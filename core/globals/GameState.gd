extends Node

## VARIÁVEIS DE ESTADO
var is_two_player: bool = false
var is_training_mode: bool = false
var player_1_character_name: String = ""
var player_2_character_name: String = ""
var selected_map_name: String = "" # Nome do mapa escolhido
var map_chice: String

## DICIONÁRIO DE PERSONAGENS
const CHARACTER_PATHS = {
	"Ken": "res://Scenes/Characters/Otavio.tscn",
	"Ryu": "res://Scenes/Characters/Cirineu.tscn",
	"Dummy": "res://Scenes/Characters/Dummy.tscn", 
}

## DICIONÁRIO DE CENÁRIOS/MAPAS
var ryu_stage = "res://main_fight_scenes/ryu/ryu_main.tscn"
var ken_stage = "res://main_fight_scenes/ken/ken_main.tscn"
var not_training_stage = "res://main_fight_scenes/not_training/not_training.tscn"

## CAMINHOS DAS CENAS
const MAP_SELECTION_SCENE_PATH = "res://stage/control.tscn" # Caminho da tela de seleção de mapa
const FIGHT_SCENE_PATH = "res://Scenes/FightStage.tscn" #Caminho da cena de luta


## FUNÇÕES DE CONTROLE DE ESTADO

func jump_to(_path) -> void:
	get_tree().change_scene_to_file(_path)

func set_game_mode(is_2p: bool, is_training: bool) -> void:
	is_two_player = is_2p
	is_training_mode = is_training
	print("Modo definido: 2P =", is_two_player, "| Treinamento =", is_training_mode)


func reset_characters() -> void:
	player_1_character_name = ""
	player_2_character_name = ""
	selected_map_name = "" # Reseta o mapa também
	print("Escolhas de personagem e mapa resetadas.")


func select_character(player_index: int, character_name: String) -> void:
	
	if player_index == 1:
		if character_name == "Ryu":
			CharsGlobals.p1n = 0
		if character_name == "Ken":
			CharsGlobals.p1n = 1
			
	if player_index == 2:
		if character_name == "Ryu":
			CharsGlobals.p2n = 0
		if character_name == "Ken":
			CharsGlobals.p2n = 1
			
	if not CHARACTER_PATHS.has(character_name):
		printerr("Erro: Personagem desconhecido:", character_name)
		return
		
	if player_index == 1:
		player_1_character_name = character_name
		print("P1 escolheu:", character_name)
	elif player_index == 2:
		player_2_character_name = character_name
		print("P2 escolheu:", character_name)
	else:
		printerr("Erro: índice de jogador inválido:", player_index)

# Função para registrar o cenário escolhido
func select_map(map_name: String) -> void:
	
	if map_name != null:
		
		if map_name == "stg1":
			jump_to(ken_stage)
			
		if map_name == "stg2":
			jump_to(ryu_stage)
			
		if map_name == "stg3":
			jump_to(not_training_stage)
		
		print("Cenário escolhido:", map_name)
		
	else:
		printerr("Erro: Cenário desconhecido:", map_name)


func get_character_scene_path(character_name: String) -> String:
	return CHARACTER_PATHS.get(character_name, "")


# Função para iniciar a seleção de mapa
func start_map_selection() -> void:
	if FileAccess.file_exists(MAP_SELECTION_SCENE_PATH):
		get_tree().change_scene_to_file(MAP_SELECTION_SCENE_PATH)
	else:
		printerr("ERRO: Cena de seleção de mapa não encontrada em:", MAP_SELECTION_SCENE_PATH)
		# Se não achar, vai direto para a luta


# Inicia a cena principal de luta/treinamento
func start_fight_scene() -> void:
	if FileAccess.file_exists(FIGHT_SCENE_PATH):
		get_tree().change_scene_to_file(FIGHT_SCENE_PATH)
	else:
		printerr("ERRO: Cena de luta não encontrada em:", FIGHT_SCENE_PATH)

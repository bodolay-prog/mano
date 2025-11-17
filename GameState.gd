extends Node

## --- VARIÁVEIS DE ESTADO ---
var is_two_player: bool = false
var is_training_mode: bool = false
var player_1_character_name: String = ""
var player_2_character_name: String = ""

## --- DICIONÁRIO DE PERSONAGENS ---
# Mapeia o nome do personagem para o caminho da cena correspondente (.tscn)
const CHARACTER_PATHS = {
	"Otavio": "res://Scenes/Characters/Otavio.tscn",
	"Cirineu": "res://Scenes/Characters/Cirineu.tscn",
	"Dummy": "res://Scenes/Characters/Dummy.tscn", # Boneco de treino
}

## --- CAMINHO DA CENA DE LUTA ---
const FIGHT_SCENE_PATH = "res://Scenes/FightStage.tscn"


## --- FUNÇÕES DE CONTROLE DE ESTADO ---

# Define o modo de jogo (chamado pelo Menu Principal)
func set_game_mode(is_2p: bool, is_training: bool) -> void:
	is_two_player = is_2p
	is_training_mode = is_training
	print("Modo definido: 2P =", is_two_player, "| Treinamento =", is_training_mode)


# Reseta as escolhas de personagem
func reset_characters() -> void:
	player_1_character_name = ""
	player_2_character_name = ""
	print("Escolhas de personagem resetadas.")


# Registra a escolha do personagem
func select_character(player_index: int, character_name: String) -> void:
	if player_index == 1:
		player_1_character_name = character_name
		print("P1 escolheu:", character_name)
	elif player_index == 2:
		player_2_character_name = character_name
		print("P2 escolheu:", character_name)
	else:
		printerr("Erro: índice de jogador inválido:", player_index)


# Inicia a cena principal de luta/treinamento
func start_fight_scene() -> void:
	if FileAccess.file_exists(FIGHT_SCENE_PATH):
		get_tree().change_scene_to_file(FIGHT_SCENE_PATH)
	else:
		printerr("ERRO: Cena de luta não encontrada em:", FIGHT_SCENE_PATH)

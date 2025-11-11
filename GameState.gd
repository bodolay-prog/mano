extends Node

## --- VARIÁVEIS DE ESTADO ---
var is_two_player: bool = false
var is_training_mode: bool = false

var player_1_character_name: String = ""
var player_2_character_name: String = ""

## --- FUNÇÕES DE CONTROLE DE ESTADO ---
func set_game_mode(is_2p: bool, is_training: bool) -> void:
	is_two_player = is_2p
	is_training_mode = is_training
	print("Modo 2P:", is_two_player, " | Treinamento:", is_training_mode)

func reset_characters() -> void:
	player_1_character_name = ""
	player_2_character_name = ""

func select_character(player_index: int, character_name: String) -> void:
	if player_index == 1:
		player_1_character_name = character_name
	elif player_index == 2:
		player_2_character_name = character_name

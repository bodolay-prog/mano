extends Control

const CHARACTER_SELECT_SCENE = "res://Scenes/CharacterSelect.tscn"

# Botão "2 Jogadores" (x_1)
func _on_x_1_pressed() -> void:
	GameState.set_game_mode(true, false) # 2 jogadores, sem treino
	GameState.reset_characters()
	get_tree().change_scene_to_file(CHARACTER_SELECT_SCENE)

# Botão "Treinamento" (x_ia)
func _on_x_ia_pressed() -> void:
	GameState.set_game_mode(false, true) # 1 jogador, treino
	GameState.reset_characters()
	get_tree().change_scene_to_file(CHARACTER_SELECT_SCENE)

# Botão "Sair"
func _on_exit_pressed() -> void:
	get_tree().quit()

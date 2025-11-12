extends Control

const SELECTION_SCENE_PATH := "res://menu.tscn"

func _ready() -> void:
	# Garante clean
	GameState.reset_characters()

func _on__x_1_pressed() -> void:
	GameState.set_game_mode(true, false)
	GameState.reset_characters()
	if FileAccess.file_exists(SELECTION_SCENE_PATH):
		get_tree().change_scene_to_file(SELECTION_SCENE_PATH)
	else:
		printerr("ERRO: Cena de seleção não encontrada em:", SELECTION_SCENE_PATH)

func _on__x_ia_pressed() -> void:
	GameState.set_game_mode(false, true)
	GameState.reset_characters()
	if FileAccess.file_exists(SELECTION_SCENE_PATH):
		get_tree().change_scene_to_file(SELECTION_SCENE_PATH)
	else:
		printerr("ERRO: Cena de seleção não encontrada em:", SELECTION_SCENE_PATH)

func _on_exit_pressed() -> void:
	get_tree().quit()

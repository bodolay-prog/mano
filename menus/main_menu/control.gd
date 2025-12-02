extends Control

const SELECTION_SCENE_PATH := "res://menus/select_char/menu.tscn"

@onready var bmg: AudioStreamPlayer = $bmg
@onready var intro: VideoStreamPlayer = $intro
@onready var sfx: AudioStreamPlayer = $sfx

func _ready() -> void:
	# Garante estado limpo antes que o jogador escolha o modo]
	intro.visible = true
	intro.play()
	GameState.reset_characters()

func play_sfx() -> void:
	sfx.play()

func skip_intro() -> void:
	intro.stop()
	intro.visible = false
	intro.finished.emit()

func _on__x_1_pressed() -> void:
	# Modo 2 Jogadores (is_2p=true, is_training=false)
	GameState.set_game_mode(true, false)
	# O reset_characters() já foi feito no _ready, mas garantimos que as escolhas não persistam
	# se por algum motivo ele voltar aqui sem reiniciar o jogo.
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


func _on_intro_finished() -> void:
	intro.visible = false
	bmg.play()
	pass # Replace with function body.

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("p1_start"):
		skip_intro()
		
	return


func _on__x_1_mouse_entered() -> void:
	play_sfx()
	pass # Replace with function body.


func _on__x_ia_mouse_entered() -> void:
	play_sfx()
	pass # Replace with function body.


func _on_exit_mouse_entered() -> void:
	play_sfx()
	pass # Replace with function body.

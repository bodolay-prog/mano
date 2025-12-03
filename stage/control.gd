extends Control

const MAP_BUTTON_GROUP = "map_selection"

@onready var stg_name: Label = $stg_name
@onready var sfx: AudioStreamPlayer = $sfx

func _ready() -> void:
	# Conecta a função de seleção a todos os botões do grupo
	for node in get_tree().get_nodes_in_group(MAP_BUTTON_GROUP):
		if node is Button:
			node.pressed.connect(_on_map_button_pressed.bind(node.name))
		else:
			print("Aviso: Nó no grupo 'map_selection' não é um botão:", node.name)

# Função única para todos os botões de cenário
func _on_map_button_pressed(map_name: String) -> void:
	# 1. Grava escolha
	# O nome do botão deve ser o nome da chave no dicionário MAP_PATHS
	GameState.map_chice = map_name
	GameState.select_map(map_name)
	Bgm.stop_music()


func _on_button_mouse_entered() -> void:
	sfx.play()
	$Preview.icon=ResourceLoader.load("res://assets/stages/ken_stage.png")
	stg_name.text = "SUBWAY"

func _on_button_2_mouse_entered() -> void:
	sfx.play()
	$Preview.icon=ResourceLoader.load("res://assets/stages/ryu_stage.png")
	stg_name.text = "DOJO"
	
func _on_stg_3_mouse_entered() -> void:
	sfx.play()
	$Preview.icon=ResourceLoader.load("res://assets/stages/training_stage.png")
	stg_name.text = "TRAINING"

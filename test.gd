extends Node2D

@export var charnode_path: NodePath

var p1_scene: PackedScene
var p2_scene: PackedScene

var p1_instance: P1Character
var p2_instance: P2Character

func _ready() -> void:
	
	# GARANTE que CharsGlobals já está pronto
	await get_tree().process_frame
	
	print("p1char_scene =", CharsGlobals.p1char_scene)

	if CharsGlobals.p1char_scene != "":
		p1_scene = load(CharsGlobals.p1char_scene)
	else:
		print("Erro: p1char_scene está vazio")
		return

	p1_instance = p1_scene.instantiate()
	p1_instance.name = "p1_instance"
	add_child(p1_instance)

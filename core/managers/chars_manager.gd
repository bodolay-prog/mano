extends Node2D

var p1_scene: PackedScene = load(CharsGlobals.p1ryuchar_path)
var p2_scene: PackedScene = load(CharsGlobals.p2kenchar_path)

@export var charnode_path: NodePath

var p1_pos := Vector2(355, 553)
var p2_pos := Vector2(809, 578)

var p1_instance: P1Character
var p2_instance: P2Character

var p1_hitbox_manager: hitbox_manager
var p2_hitbox_manager: hitbox_manager

func _ready() -> void:
	load_chars()

func load_chars() -> void:
	
	var container = get_node(charnode_path)

	if CharsGlobals.p1char_scene:
		p1_instance = p1_scene.instantiate()
		p1_instance.name = "p1_instance"
		container.add_child(p1_instance)
		p1_instance.global_position = p1_pos

		p1_hitbox_manager = p1_instance.get_node("hitbox_manager")

	if CharsGlobals.p2char_scene:
		p2_instance = p2_scene.instantiate()
		p2_instance.name = "p2_instance"
		container.add_child(p2_instance)
		p2_instance.global_position = p2_pos

		p2_hitbox_manager = p2_instance.get_node("hitbox_manager")

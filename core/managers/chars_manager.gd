extends Node2D

var p1_scene: PackedScene 
var p2_scene: PackedScene 

@export var charnode_path: NodePath

@onready var p1_spawn = $"../p1_spawn_pos"
@onready var p2_spawn = $"../p2_spawn_pos"

@onready var p1_pos = p1_spawn.global_position
@onready var p2_pos = p2_spawn.global_position

var p1_instance: P1Character
var p2_instance: P2Character

var p1_hitbox_manager: hitbox_manager
var p2_hitbox_manager: hitbox_manager

func _ready() -> void:
	
	await get_tree().process_frame
	
	p1_scene = load(CharsGlobals.p1char_scene)
	p2_scene = load(CharsGlobals.p2char_scene)
	
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

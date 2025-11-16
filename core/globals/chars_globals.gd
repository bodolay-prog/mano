extends Node2D

var p1char_path: String = "res://actors/characters/p1_chars/test_char/p1_test_player.tscn"
var p2char_path: String = "res://actors/characters/p2_chars/test_player/p_2_test_player.tscn"

@onready
var p2char_scene: PackedScene = load(p2char_path)
@onready
var p1char_scene: PackedScene = load(p1char_path)

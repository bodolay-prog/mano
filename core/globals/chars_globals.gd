extends Node2D

var p1char_path: String = "res://actors/characters/p1_chars/test_char/p1_test_player.tscn"
var p2char_path: String = "res://actors/characters/p2_chars/test_player/p_2_test_player.tscn"
var p1ryuchar_path: String = "res://actors/characters/p1_chars/shoto_ryu/p1_ryu_character.tscn"
var p2ryuchar_path: String = "res://actors/characters/p2_chars/shoto_ryu/p2_ryu_character.tscn"
var p1kenchar_path: String = "res://actors/characters/p1_chars/shoto_ken/p1_ken_character.tscn"
var p2kenchar_path: String = "res://actors/characters/p2_chars/shoto_ken/p2_ken_character.tscn"


@onready
var p1char_scene: PackedScene = load(p1ryuchar_path)
@onready
var p2char_scene: PackedScene = load(p2kenchar_path)

var p1: P1Character
var p2: P2Character

var p1hitboxall: hitbox_manager 
var p2hitboxall: hitbox_manager 

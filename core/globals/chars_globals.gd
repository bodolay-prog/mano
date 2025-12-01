extends Node2D

var p1n: int 
var p2n: int 

var p1ryuchar_path := "res://actors/characters/p1_chars/shoto_ryu/p1_ryu_character.tscn"
var p2ryuchar_path := "res://actors/characters/p2_chars/shoto_ryu/p2_ryu_character.tscn"
var p1kenchar_path := "res://actors/characters/p1_chars/shoto_ken/p1_ken_character.tscn"
var p2kenchar_path := "res://actors/characters/p2_chars/shoto_ken/p2_ken_character.tscn"

var p1char_array := [p1ryuchar_path, p1kenchar_path]
var p2char_array := [p2ryuchar_path, p2kenchar_path]

var p1char_scene := ""
var p2char_scene := ""

var p1: P1Character
var p2: P2Character

var p1hitboxall: hitbox_manager 
var p2hitboxall: hitbox_manager 

func _process(delta: float) -> void:
	
	#print(p1char_scene, p1n)
	#print(p2char_scene, p2n)
	#print("p1n:", p1n)
	#print("p2n:", p2n)
	p1char_scene = p1char_array[p1n]
	p2char_scene = p2char_array[p2n]
	pass

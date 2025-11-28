extends Node


var hdkp1_scene_path = "res://core/combat/hadouken/hadoukenP1.tscn"
var hdkp2_scene_path = "res://core/combat/hadouken/hadoukenP2.tscn"

@onready
var hdkp1_scene: PackedScene = load(hdkp1_scene_path)
@onready
var hdkp2_scene: PackedScene = load(hdkp2_scene_path)

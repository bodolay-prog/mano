class_name HealthBarP2
extends Control

@onready
var sprite2d: Sprite2D = $CanvasLayer/char_portrait
@onready
var name_char: Label = $CanvasLayer/health_bar/name_char

var texture_path 
var text_name

func change_portrait() -> void:
	
	sprite2d.texture = load(texture_path)
	
func change_name() -> void:
	
	name_char.text = text_name
	
	
func set_things() -> void:
	
	change_name()
	change_portrait()

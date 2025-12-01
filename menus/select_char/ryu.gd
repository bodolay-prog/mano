class_name ColorRyu
extends ColorRect

@onready var animations: AnimationPlayer = $animation
@onready var vl: AudioStreamPlayer = $vl

func _ready() -> void:
	animations.play("idle")
	
func reset_ani() -> void:
	animations.play("idle")

func _on_ryu_pressed() -> void:
	vl.play()
	animations.play("on_select")
	
	pass # Replace with function body.

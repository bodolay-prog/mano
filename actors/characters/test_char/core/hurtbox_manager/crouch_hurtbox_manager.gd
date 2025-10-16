extends crouch_hurtbox

func _on_body_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("test_enemy"):
		on_crouch_hurtbox_hit()
	pass # Replace with function body.

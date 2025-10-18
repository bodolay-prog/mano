extends air_hurtbox

func _on_body_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("hitbox_test_enemy"):
		on_air_hurtbox_hit()
	pass # Replace with function body.

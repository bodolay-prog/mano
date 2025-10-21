extends ground_hurtbox

func _on_body_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hitbox"):
		on_ground_hurtbox_hit()
	pass # Replace with function body.

extends ground_hurtbox

func _on_ground_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hitbox"):
		on_ground_hurtbox_hit()

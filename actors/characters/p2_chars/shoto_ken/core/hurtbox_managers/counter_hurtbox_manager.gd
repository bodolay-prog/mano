extends counter_hurtbox


func _on_counter_hurtbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hitbox"):
		on_counter_hurtbox_hit()
	pass # Replace with function body.

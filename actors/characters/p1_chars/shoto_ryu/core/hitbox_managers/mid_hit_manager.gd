extends mid_hit


func _on__5_l_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hurtbox"):
		on_hit(, 0, 200, 0)
	pass # Replace with function body.


func _on__5_m_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hurtbox"):
		on_hit(0, 20, 0, 0)
	pass # Replace with function body.


func _on__5_h_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hurtbox"):
		on_hit(0, 0, 0, 0)
	pass # Replace with function body.

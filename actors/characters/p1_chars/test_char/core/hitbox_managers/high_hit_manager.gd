extends high_hit

func _on_j_5_l_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hurtbox"):  
		on_hit(2, 0, 0, 0)
	pass # Replace with function body.


func _on_j_5_m_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hurtbox"):  
		on_hit(4, 1, 0, 0)
	pass # Replace with function body.


func _on_j_5_h_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hurtbox"): 
		on_ender(5, 2, 0, 0)
	pass # Replace with function body.

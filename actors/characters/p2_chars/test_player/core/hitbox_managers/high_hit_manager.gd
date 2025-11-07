extends high_hit

func _on_j_5_l_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(2, 0, 125, 100)


func _on_j_5_m_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(4, 1, 200, 120)


func _on_j_5_h_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"): 
		on_hit(5, 2, 250, 150)

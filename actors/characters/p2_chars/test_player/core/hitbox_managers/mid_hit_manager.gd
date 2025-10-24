extends mid_hit

func _on__l_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"): 
		on_hit(20, 12, 0, 0)


func _on__m_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"): 	
		on_hit(4, 32, 0, 0)


func _on__h_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"): 
		on_hit(2, 2, 0, 0)

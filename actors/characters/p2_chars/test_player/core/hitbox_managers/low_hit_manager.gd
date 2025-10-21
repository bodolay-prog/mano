extends low_hit

func _on__l_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(1,0)


func _on__m_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(2,-1)


func _on__h_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(3,-5)

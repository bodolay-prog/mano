extends low_hit

func _on__l_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hurtbox"):  
		on_hit(1, 0, 0, 0)
	pass # Replace with function body.


func _on__m_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hurtbox"):  
		on_hit(2, -1, 0, 0)
	pass # Replace with function body.


func _on__h_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hurtbox"):  
		on_launcher(3, -5, 0, 0)
	pass # Replace with function body.

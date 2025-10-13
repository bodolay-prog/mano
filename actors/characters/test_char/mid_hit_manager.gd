extends mid_hit

func _on__l_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("test_enemy"): 
		on_hit(5,4)
	pass # Replace with function body.


func _on__m_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("test_enemy"): 	
		on_hit(4,4)
	pass # Replace with function body


func _on__h_area_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("test_enemy"): 
		on_hit(2,2)
	pass # Replace with function body.

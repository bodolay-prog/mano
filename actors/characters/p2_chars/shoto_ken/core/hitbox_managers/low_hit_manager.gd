extends low_hit


func _on__2_l_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(2, 20, 0, 0)
	pass # Replace with function body.


func _on__2_m_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(2, 20, 0, 0)
	pass # Replace with function body.


func _on__2_h_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_launcher(2, 20, 0, 0)
	pass # Replace with function body.


func _on__3_h_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_sweep(2, 20, 0, 0)
	pass # Replace with function body.

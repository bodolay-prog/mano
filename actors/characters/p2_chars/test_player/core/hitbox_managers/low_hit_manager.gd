extends low_hit

func _on__l_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(1, 0, 100, 120)
	pass # Replace with function body.

func _on__m_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(2, 1, 200, 140)
	pass # Replace with function body.

func _on__h_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_launcher(3, 5, 250, 150)
	pass # Replace with function body.

func _on__3_h_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_sweep(1, 40, 300, 0)
	pass # Replace with function body

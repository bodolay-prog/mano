extends special_hit


func _on_tmk_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(2, 0, 0, 150, 250)
	pass # Replace with function body.


func _on_tmk_ender_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(2, 0, 0, 0, 0)
	pass # Replace with function body.


func _on_srk_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(2, 0, 0, 0, 0)
	pass # Replace with function body.


func _on_srk_ender_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(2, 0, 0, 0, 0)
	pass # Replace with function body.

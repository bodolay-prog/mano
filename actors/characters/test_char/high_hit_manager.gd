extends high_hit

func _on_j_5_l_area_area_entered(area: Area2D) -> void:
	print("j5l")
	on_hit(2,0)
	pass # Replace with function body.


func _on_j_5_m_area_area_entered(area: Area2D) -> void:
	print("j5m")
	on_hit(4,1)
	pass # Replace with function body.


func _on_j_5_h_area_area_entered(area: Area2D) -> void:
	print("j5H")
	on_hit(5,2)
	pass # Replace with function body.


func _on_j_5_l_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("j5l")
	on_hit(2,0)
	pass # Replace with function body.

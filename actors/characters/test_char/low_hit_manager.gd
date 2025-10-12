extends low_hit


func _on__l_area_area_entered(area: Area2D) -> void:
	on_hit(1,0)
	pass # Replace with function body.


func _on__m_area_area_entered(area: Area2D) -> void:
	on_hit(2,-1)
	pass # Replace with function body.


func _on__h_area_area_entered(area: Area2D) -> void:
	on_hit(3,-5)
	pass # Replace with function body.

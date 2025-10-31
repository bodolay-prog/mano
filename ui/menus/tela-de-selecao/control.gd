extends Control


func _on_ButtonOtavio_mouse_entered()-> void: 
	get_node("Select/DonOtavio").color = Color.YELLOW
	
func _on_ButtonOtavio_mouse_exited()-> void:
	get_node("Select/DonOtavio").color = Color.WHITE
	
func _on_ButtonDanielzin_mouse_entered()-> void: 
	get_node("Select/Danielzin").color = Color.YELLOW
	
func _on_ButtonDanielzin_mouse_exited()-> void:
	get_node("Select/Danielzin").color = Color.WHITE
	
func _on_ButtonCirineu_mouse_entered()-> void: 
	get_node("Select/SirCirineu").color = Color.YELLOW
	
func _on_ButtonCirineu_mouse_exited()-> void:
	get_node("Select/SirCirineu").color = Color.WHITE

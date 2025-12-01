extends special_hit

var block_stun_frames: int 
var hit_stun_frames:int 
var damage: int 
var knockback: int 
var knockback_y: int

var ender_block_stun_frames: int 
var ender_hit_stun_frames:int 
var ender_damage: int 
var ender_knockback: int 
var ender_knockback_y: int

func _on_tmk_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(block_stun_frames, hit_stun_frames, damage, knockback, knockback_y)
	pass # Replace with function body.


func _on_tmk_ender_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(ender_block_stun_frames, ender_hit_stun_frames, ender_damage, ender_knockback, ender_knockback_y)
	pass # Replace with function body.


func _on_srk_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(block_stun_frames, hit_stun_frames, damage, knockback, knockback_y)
	pass # Replace with function body.


func _on_srk_ender_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):  
		on_hit(ender_block_stun_frames, ender_hit_stun_frames, ender_damage, ender_knockback, ender_knockback_y)
	pass # Replace with function body.

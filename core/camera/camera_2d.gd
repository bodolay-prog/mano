extends Camera2D

@onready
var left_area: Area2D = $left_all/left_side_area
@onready
var right_area: Area2D = $right_all/right_side_area


func _process(delta):
	var left_side = []
	var right_side = []
	
	for area in left_area.get_overlapping_areas():
		if area.is_in_group("char"):
			left_side.append(area)
			
	for area in right_area.get_overlapping_areas():
		if area.is_in_group("char"):
			right_side.append(area)
			
	if left_side.size() > 0:
	#	print("left")
		position.x -= 10
	else:
		position.x -= 0
		
	if right_side.size() > 0:
		#print("right")
		position.x += 10
		
	else:
		position.x += 0
	

	

extends Node

func movement_inputs() -> int:
	
	if Input.is_action_pressed('p2_down'):
		if Input.is_action_pressed('p2_up'):
			return 5
		if Input.is_action_pressed('p2_left'):
			return 1
		if Input.is_action_pressed('p2_right'):
			return 3
		return 2
		
	if Input.is_action_pressed('p2_left'):
		if Input.is_action_just_pressed('p2_dash'):
			return 44
		if Input.is_action_pressed('p2_up'):
			return 7
		if Input.is_action_pressed('p2_right'):
			return 5
		return 4
		
	if Input.is_action_pressed('p2_right'):
		if Input.is_action_just_pressed('p2_dash'):
			return 66
		if Input.is_action_pressed('p2_left'):
			return 5
		if Input.is_action_pressed('p2_up'):
			return 9
		return 6
		
	if Input.is_action_pressed('p2_up'):
		return 8
	return 5
	
	
func attack_inputs() -> String:
	
	if Input.is_action_just_pressed('p2_L'):
		return "L"
	if Input.is_action_just_pressed('p2_M'):
		return "M"
	if Input.is_action_just_pressed('p2_H'):
		return "H"
	return "N"
		

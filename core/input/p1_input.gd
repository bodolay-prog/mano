extends Node

@onready
var p1 = $".."
var dir 


func movement_inputs() -> int:
	dir = 5
	
	if Input.is_action_pressed('p1_down'):
		if Input.is_action_pressed('p1_up'):
			dir = 5
		if Input.is_action_pressed('p1_left'):
			dir = 1 
		if Input.is_action_pressed('p1_right'):
			dir = 3
		dir = 2
		
	if Input.is_action_pressed('p1_left'):
		if Input.is_action_just_pressed('p1_dash'):
			dir = 44
		if Input.is_action_pressed('p1_up'):
			dir = 7
		if Input.is_action_pressed('p1_right'):
			dir = 5
		dir = 4
		
	if Input.is_action_pressed('p1_right'):
		if Input.is_action_just_pressed('p1_dash'):
			dir = 66
		if Input.is_action_pressed('p1_left'):
			dir = 5
		if Input.is_action_pressed('p1_up'):
			dir = 9
		dir = 6
		
	if Input.is_action_pressed('p1_up'):
		dir = 8
	
	
	return dir

func attack_inputs() -> String:
	
	if Input.is_action_just_pressed('p1_L'):
		return "L"
	if Input.is_action_just_pressed('p1_M'):
		return "M"
	if Input.is_action_just_pressed('p1_H'):
		return "H"
	return "N"
		

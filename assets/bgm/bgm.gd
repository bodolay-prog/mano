extends AudioStreamPlayer

const stg_char_select_bmg = preload("res://assets/bgm/Marvel-Vs.-Capcom-2_-Character-Select.ogg")



func _play_music(music: AudioStream) -> void:

	if stream == music:
		return
	
	volume_db = -30
	stream = music
	play() 

func play_music_level(): 
	_play_music(stg_char_select_bmg)
	
func stop_music() -> void:
	stop()

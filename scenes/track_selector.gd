extends Node


var track_1 = preload("res://scenes/track_1.tscn")
var track_2 = preload("res://scenes/track_2.tscn")


func select_track(track:int) -> void:
	var current_track
	if track == 1:
		current_track = track_1.instantiate()
	elif track == 2:
		current_track = track_2.instantiate()
	else:
		assert("select_track: 'track' is out of range")
	
	add_child(current_track)

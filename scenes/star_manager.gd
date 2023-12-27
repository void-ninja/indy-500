extends Node

@export var star_count: int = 0

var star = preload("res://scenes/star.tscn")

func _ready() -> void:
	if get_parent().name != "Main": 
		if get_parent().visible:
			for i in star_count:
				var new_star = star.instantiate()
				new_star.global_position = Vector2(
					randi_range(0, ProjectSettings.get_setting("display/window/size/viewport_width")),
					randi_range(0, ProjectSettings.get_setting("display/window/size/viewport_height"))
				)
				add_child(new_star)
	else:
		for i in star_count:
			var new_star = star.instantiate()
			new_star.global_position = Vector2(
				randi_range(-200, ProjectSettings.get_setting("display/window/size/viewport_width")+400),
				randi_range(-200, ProjectSettings.get_setting("display/window/size/viewport_height")+400)
			)
			add_child(new_star)

extends Node2D

@onready var static_body_2d: StaticBody2D = $StaticBody2D
@onready var line_manager: Node = $LineManager


func _ready():
	for line in line_manager.get_children():
		for i in line.points.size() - 1:
			var new_shape = CollisionShape2D.new()
			static_body_2d.add_child(new_shape)
			var rect = RectangleShape2D.new()
			new_shape.position = (line.points[i] + line.points[i + 1]) / 2
			new_shape.rotation = line.points[i].direction_to(line.points[i + 1]).angle()
			var length = line.points[i].distance_to(line.points[i + 1])
			rect.extents = Vector2(length / 2, 5)
			new_shape.shape = rect

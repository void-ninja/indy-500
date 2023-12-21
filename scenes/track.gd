extends Node2D

@onready var line_2d: Line2D = $Line2D
@onready var static_body_2d: StaticBody2D = $StaticBody2D
@onready var line_2d_2: Line2D = $Line2D2


func _ready():
	for i in line_2d.points.size() - 1:
		var new_shape = CollisionShape2D.new()
		static_body_2d.add_child(new_shape)
		var rect = RectangleShape2D.new()
		new_shape.position = (line_2d.points[i] + line_2d.points[i + 1]) / 2
		new_shape.rotation = line_2d.points[i].direction_to(line_2d.points[i + 1]).angle()
		var length = line_2d.points[i].distance_to(line_2d.points[i + 1])
		rect.extents = Vector2(length / 2, 5)
		new_shape.shape = rect
		
	for i in line_2d_2.points.size() - 1:
		var new_shape = CollisionShape2D.new()
		static_body_2d.add_child(new_shape)
		var rect = RectangleShape2D.new()
		new_shape.position = (line_2d_2.points[i] + line_2d_2.points[i + 1]) / 2
		new_shape.rotation = line_2d_2.points[i].direction_to(line_2d_2.points[i + 1]).angle()
		var length = line_2d_2.points[i].distance_to(line_2d_2.points[i + 1])
		rect.extents = Vector2(length / 2, 5)
		new_shape.shape = rect

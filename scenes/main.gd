extends Node

@onready var camera_2d: Camera2D = $Camera2D
@onready var player_1: CharacterBody2D = $Player1
@onready var player_2: CharacterBody2D = $Player2

func _physics_process(delta: float) -> void:
	camera_2d.global_position.x = (player_1.global_position.x + player_2.global_position.x)/2
	camera_2d.global_position.y = (player_1.global_position.y + player_2.global_position.y)/2
	

extends Node

@onready var camera_2d: Camera2D = $Camera2D
@onready var player_1: CharacterBody2D = $Player1
@onready var player_2: CharacterBody2D = $Player2


func _ready() -> void:
	camera_2d.add_target(player_1)
	camera_2d.add_target(player_2)


func _physics_process(delta: float) -> void:
	pass


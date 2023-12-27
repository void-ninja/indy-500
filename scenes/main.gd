extends Node

@onready var camera_2d: Camera2D = $Camera2D
@onready var player_1: CharacterBody2D = $Player1
@onready var player_2: CharacterBody2D = $Player2
@onready var track_selector: Node = $TrackSelector
@onready var main_menu: Control = $"UI/Main Menu"
@onready var in_game_ui: Control = $"UI/In-Game"


func _ready() -> void:
	camera_2d.add_target(player_1)
	camera_2d.add_target(player_2)
	

func _physics_process(delta: float) -> void:
	pass
	

func _on_start_button_button_up() -> void:
	main_menu.visible = false
	for i in $"UI/Main Menu/StarManager2".get_children():
		i.visible = false
	in_game_ui.visible = true
	var track = $"UI/Main Menu/TrackSelect".current_tab + 1
	track_selector.select_track(track)

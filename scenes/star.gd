extends Node2D

var animation_speed: float
var animation_counter: int
var modulation_amount: float

func _ready() -> void:
	var scale_int = randi_range(1,3)
	scale.x = scale_int
	scale.y = scale_int
	rotation_degrees = randi_range(0,360)
	
	animation_speed = randi_range(60, 600)
	animation_counter = animation_speed
	
	modulation_amount = 1 / animation_speed


func _physics_process(delta: float) -> void:
	if animation_counter < 1:
		modulate.a = animation_counter * modulation_amount * -1
		if animation_counter < -animation_speed:
			animation_counter = animation_speed
	else: 
		modulate.a = animation_counter * modulation_amount

	animation_counter -= 1

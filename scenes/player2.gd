extends CharacterBody2D

#ATTENTION MAKE CHANGES IN THE PLAYER1 SCRIPT, THEN COPY THEM TO HERE

@export var wheel_base = 100
@export var steering_angle = 40

@export var friction = -55
@export var drag = -0.06

@export var engine_power = 900 #forward acceleration force

var acceleration = Vector2.ZERO

var steer_direction

@export var braking = -450
@export var max_speed_reverse = 250

@export var slip_speed = 400  # Speed where traction is reduced
@export var traction_fast = 2.5 # High-speed traction
@export var traction_slow = 10  # Low-speed traction
@export var traction_drift = 0.8

var drift_counter: int


func _physics_process(delta: float) -> void:
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()


func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 10:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force


func get_input():
	var turn = Input.get_axis("p2_left","p2_right")
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("p2_up"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("p2_down"):
		acceleration = transform.x * braking
	if Input.is_action_pressed("p2_drift") and Input.is_action_pressed("p2_left") or \
			Input.is_action_pressed("p2_right"):
		# to compensate for loss of acceleration during drift
		acceleration = transform.x * (engine_power * 1.5) 
		drift_counter += 1
	else:
		var rotation_vector = Vector2(cos(rotation),sin(rotation))
		if drift_counter > 120:
			velocity += velocity * 2
			velocity = abs(velocity) * (rotation_vector/abs(rotation_vector))
		elif drift_counter > 60:
			velocity += velocity * 1.3
			velocity = abs(velocity) * (rotation_vector/abs(rotation_vector))
		drift_counter = 0
		

func calculate_steering(delta):
	# 1. Find the wheel positions
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	# 2. Move the wheels forward
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	# 3. Find the new direction vector
	var new_heading = rear_wheel.direction_to(front_wheel)
	# choose which traction value to use - at lower speeds, slip should be low
	var traction = traction_slow
		
	if velocity.length() > slip_speed:
		traction = traction_fast
	if Input.is_action_pressed("p2_drift"):
		traction = traction_drift
	# 4. Set the velocity and rotation to the new direction
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()

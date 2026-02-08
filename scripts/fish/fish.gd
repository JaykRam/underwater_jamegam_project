extends CharacterBody2D

@export var speed := 80.0

# Aquarium Bounds
@export var min_bounds := Vector2(0,0)
@export var max_bounds := Vector2(800, 600)

var move_direction := Vector2.ZERO

#Functions

func _ready():
	pick_new_direction()

func pick_new_direction():
	move_direction = Vector2(
		randf_range(-1,1),
		randf_range(-0.6, 0.6)
	).normalized()

func _on_direction_timer_timeout():
	pick_new_direction()

# Movement - Yup, always physics process delta

func _physics_process(delta):
	velocity = move_direction * speed
	move_and_slide()
	keep_inside_aquarium()

func keep_inside_aquarium():
	var pos := global_position
	var bounced := false
	
	if pos.x < min_bounds.x:
		pos.x = min_bounds.x
		move_direction.x *= -1
		bounced = true
	elif pos.x > max_bounds.x:
		pos.x = max_bounds.x
		move_direction.x *= -1
		bounced = true
		
	if pos.y < min_bounds.y:
		pos.y = min_bounds.y
		move_direction.y *= -1
		bounced = true
	elif pos.y > max_bounds.y:
		pos.y = max_bounds.y
		move_direction.y *= -1
		bounced = true
		
	if bounced:
		move_direction = move_direction.normalized()
		
	global_position = pos

# Turning Animation - Tweening

func _process(delta):
	if move_direction.length() > 0.1:
		rotation = lerp_angle(rotation, move_direction.angle(), 5 * delta)

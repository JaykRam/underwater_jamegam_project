extends Node2D

@export var note_scene: PackedScene

@export var note_power := 1
@export var note_amount := 1
@export var note_bounces := 1
@export var cooldown := 3.0

var can_fire := true

func fire_notes():
	if not can_fire:
		return
	
	can_fire = false
	$"Cooldown Timer".start(cooldown)
	
	for i in note_amount:
		spawn_note()


#

func spawn_note():
	var note = note_scene.instantiate()
	get_parent().add_child(note)
	
	note.global_position = $"Note Spawn".global_position
	note.power = note_power
	note.bounces_left = note_bounces
	
	# Shotgun spread (in radians)
	var spread := randf_range(-PI / 4, PI / 4) # 45° left/right
	var direction := Vector2.DOWN.rotated(spread)
	
	note.velocity = direction * note.speed

#

func _on_cooldown_timer_timeout():
	can_fire = true

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		fire_notes()

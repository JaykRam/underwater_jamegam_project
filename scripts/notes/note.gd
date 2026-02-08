extends CharacterBody2D

var power := 1
var bounces_left := 3
var speed := 400.0

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		
		if collider.is_in_group("walls"):
			velocity = velocity.bounce(collision.get_normal())
			bounces_left -= 1
			
			if bounces_left <= 0:
				queue_free()
		
		elif collider.is_in_group("fish"):
			GameManager.add_xp(power)
			print("HIT")
			queue_free()

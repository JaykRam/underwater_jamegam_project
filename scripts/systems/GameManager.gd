extends Node

var current_level = 1
var xp_to_next_level = 5.0

var current_xp = 0:
	set(value):
		current_xp = value
		if current_xp >= xp_to_next_level:
			level_up()

func add_xp(amount):
	print("XP MF")
	self.current_xp += amount

func level_up():
	current_level += 1
	current_xp -= xp_to_next_level
	xp_to_next_level = int(xp_to_next_level * 1.5)
	print("LEVEL UP! ", current_level, " NEED ", xp_to_next_level)

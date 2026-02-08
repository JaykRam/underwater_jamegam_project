extends Node2D

var base_xp = 0
var base_level = 1

@onready var xp_bar = $"ExpBarFill"
@onready var level_label = $"LevelLabel"

func _ready():
	update_ui()

func _process(delta):
	level_label.text = str(GameManager.current_level)
	if base_level < GameManager.current_level:
		base_level += 1
		update_ui()
		print("LEVEL UP CHAT")
	

func update_ui():
	var ratio = float(GameManager.current_xp) / GameManager.xp_to_next_level
	xp_bar.scale.x = ratio
	level_label.text = "FLV. " + str(base_level)

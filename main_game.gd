extends Node2D
@export var castle : PackedScene
@export var y_spacing : int

# Called when the node enters the scene tree for the first time.
func _ready():
	castle_load("WASD")
	castle_load("ARW")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# castle = preload("res://castle.tscn")
	# var c = castle.instantiate()
	# get_tree().root.add_child(c)
	# c.PLAYER_TYPE = "WASD"
	# test for git 2
	pass
	
func castle_load(player_type):
	for i in range(4):
		var castle = preload("res://castle.tscn").instantiate()
		castle.PLAYER_TYPE = player_type
		match(player_type):
			"WASD":
				castle.position = Vector2(110,-100 + (i * y_spacing))
			"ARW":
				castle.position = Vector2(1100,-100 + (i * y_spacing))
		add_child(castle)

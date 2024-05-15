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

func player_load(player_type):
	var player = preload("res://player.tscn").instantiate()
	player.PLAYER_TYPE = player_type
	player.SPEED = 500
	player.name = player_type + " player"
	match(player_type):
			"WASD":
				player.position = Vector2(250 ,450)
			"ARW":
				player.position = Vector2(923 ,450)
	add_child(player)
	
func castle_load(player_type):
	player_load(player_type)
	
	for i in range(3):
		var castle = preload("res://castle.tscn").instantiate()
		castle.PLAYER_TYPE = player_type
		castle.name = player_type + "_castle" + str(i + 1)
		match(player_type):
			"WASD":
				castle.position = Vector2(98,146 + (i * y_spacing))
			"ARW":
				castle.position = Vector2(1075,146 + (i * y_spacing))
		add_child(castle)
	

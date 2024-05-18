extends Node2D
@export var castle : PackedScene
@export var y_spacing : int

# Called when the node enters the scene tree for the first time.
func _ready():
	main_set_game()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.WINNER != "NONE":
		$Timer.start()
		

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
	

func main_set_game():
	$WASD_counter.text = str(Game.WASD_WINS)
	$ARW_counter.text = str(Game.ARW_WINS)
	player_load("WASD")
	castle_load("WASD")
	player_load("ARW")
	castle_load("ARW")

func _on_timer_timeout():
	Game.WINNER = "NONE"
	Game.set_game()
	main_set_game()

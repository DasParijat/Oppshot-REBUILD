extends Node2D
@export var castle : PackedScene
@export var y_spacing : int

# Called when the node enters the scene tree for the first time.
func _ready():
	set_game()
	
func set_game():
	Game.ROUND += 1
	$gamestart_audio.play()
	
	# initialize win counters for both sides
	$WASD_counter.text = str(Game.WASD_WINS)
	$WASD_counter.modulate = Game.WASD_color
	$ARW_counter.text = str(Game.ARW_WINS)
	$ARW_counter.modulate = Game.ARW_color
	
	Game.reset_max_castles()
	
	player_load("WASD")
	castle_load("WASD")
	player_load("ARW")
	castle_load("ARW")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.WINNER != "NONE":
		$ResetGameTimer.start()
		
func player_load(player_type):
	var player = preload("res://player.tscn").instantiate()
	player.PLAYER_TYPE = player_type
	player.SPEED = 600
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


func _on_timer_timeout(): # ResetGameTimer timeout
	Game.WINNER = "NONE"
	set_game()


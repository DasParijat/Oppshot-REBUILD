extends StaticBody2D
@export var PLAYER_TYPE : String
@export var health_component : Node2D

var can_damaged : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$Icon.modulate = Game.WASD_color
	$PointLight2D.set_color(Game.WASD_color)
	if PLAYER_TYPE == "ARW":
		$Icon.modulate = Game.ARW_color
		$PointLight2D.set_color(Game.ARW_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.WINNER != "NONE":
		queue_free()
	# Game.WASD_numcastles
	
func _on_area_2d_area_entered(area):
	var tween = create_tween()
	# print("I collided with ")
	if health_component && can_damaged:
		health_component.take_damage()
		var health_size = (health_component.health/5.0) + 0.2
		tween.tween_property($".", "scale", Vector2(health_size,health_size), 0.2)
		
		# console text
		# var health_string : String = str(health_component.health)
		# print(health_string + "HP left for " + PLAYER_TYPE + " Castle")
	
	# death condition
	if health_component.health <= 0:
		#await tween.finished
		can_damaged = false
		tween.tween_property($".", "scale", Vector2(0,0), 0.2)
		print(Game.WASD_numcastles)
		if PLAYER_TYPE == "ARW":
			Game.ARW_numcastles -= 1
			if Game.ARW_numcastles <= 0:
				Game.WASD_WINS += 1
				Game.WINNER = "WASD"
				print(Game.WASD_WINS)
				print("WASD WON!")
		else:
			Game.WASD_numcastles -= 1
			print(Game.WASD_numcastles)
			if Game.WASD_numcastles <= 0:
				Game.ARW_WINS += 1
				Game.WINNER = "ARW"
				print(Game.ARW_WINS)
				print("ARW WON!")
		await tween.finished
		queue_free()
	


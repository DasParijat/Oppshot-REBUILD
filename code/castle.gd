extends StaticBody2D
@export var PLAYER_TYPE : String
@export var health_component : Node2D

var can_damaged : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	match(PLAYER_TYPE):
		"WASD":
			$Icon.modulate = Game.WASD_color
			$PointLight2D.set_color(Game.WASD_color)
		"ARW":
			$Icon.modulate = Game.ARW_color
			$PointLight2D.set_color(Game.ARW_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.WINNER != "NONE":
		queue_free()
	
func _on_area_2d_area_entered(area):
	var tween = create_tween()
	
	if health_component && can_damaged:
		$hit_audio.play()
		health_component.take_damage()
		
		# scaling variables for when health goes down
		var health_size = (health_component.health/5.0) + 0.2
		tween.tween_property($".", "scale", Vector2(health_size,health_size), 0.2)
	
	death_condition(tween)

func death_condition(tween):
	if health_component.health <= 0 && can_damaged:
		$death_audio.play()
		
		can_damaged = false
		tween.tween_property($".", "scale", Vector2(0,0), 1)
		
		match(PLAYER_TYPE):
			"WASD":
				Game.WASD_numcastles -= 1
				await tween.finished
				
				# check if all castles are gone
				if Game.WASD_numcastles <= 0:
					Game.ARW_WINS += 1
					Game.WINNER = "ARW"
			"ARW":
				Game.ARW_numcastles -= 1
				await tween.finished
				
				# check if all castles are gone
				if Game.ARW_numcastles <= 0:
					Game.WASD_WINS += 1
					Game.WINNER = "WASD"
				
		queue_free()


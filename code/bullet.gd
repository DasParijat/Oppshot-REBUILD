extends Area2D

@export var speed = 750
@export var player_type : String

func _ready():
	match(player_type):
		"WASD":
			$Icon.modulate = Game.WASD_color
			$PointLight2D.set_color(Game.WASD_color)
		"ARW":
			$Icon.modulate = Game.ARW_color
			$PointLight2D.set_color(Game.ARW_color)
		_: # default statement in java
			$Icon.modulate = Color8(255, 255, 255)
	
func _process(delta):
	position += transform.x * speed * delta
	if position.x > 1200 || position.x < -25 || Game.WINNER != "NONE":
		queue_free()
	
func _on_area_entered(area):
	if area.is_in_group("hittable"):
		queue_free()

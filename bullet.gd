extends Area2D

@export var speed = 750

	
func _process(delta):
	position += transform.x * speed * delta
	if position.x > 1200 || position.x < -25 || Game.WINNER != "NONE":
		queue_free()
	
func _on_area_entered(area):
	if area.is_in_group("hittable"):
		queue_free()

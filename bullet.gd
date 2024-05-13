extends Area2D

@export var speed = 750

	
func _process(delta):
	position += transform.x * speed * delta
	
func _on_area_entered(area):
	if area.is_in_group("hittable"):
		queue_free()

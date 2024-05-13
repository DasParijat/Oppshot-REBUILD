extends Node2D

@export var MAX_HEALTH : float = 10
var health = MAX_HEALTH

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func take_damage():
	health -= 1
	


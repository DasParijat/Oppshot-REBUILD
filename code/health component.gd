extends Node2D

# base health
@export var MAX_HEALTH : float = 5
var health : float

# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func take_damage():
	health -= 1
	

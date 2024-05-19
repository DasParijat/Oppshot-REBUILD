extends CharacterBody2D

@export var PLAYER_TYPE = ""
@export var SPEED = 500
@export var bullet_scene : PackedScene
@export var health_component : Node2D 
var can_shoot : bool = true
var FRICTION = 0.2

#@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	$NewHdArrow.modulate = Game.WASD_color
	if PLAYER_TYPE == "ARW":
		scale.x=-1
		$NewHdArrow.modulate = Game.ARW_color
	#timer.timeout.connect(_on_timer_timeout)
	#timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_action_pressed(PLAYER_TYPE + "_right"):
	#	position += Vector2(0, SPEED * delta)
		
	#if Input.is_action_pressed(PLAYER_TYPE + "_left"):
	#	position += Vector2(0, -SPEED * delta)
	
	movement((PLAYER_TYPE + "_left"), (PLAYER_TYPE + "_right"), delta)
	
	if Input.is_action_just_pressed(PLAYER_TYPE + "_shoot") && can_shoot:
		#print(position.y)
		can_shoot = false
		shoot()
		$Timer.start()
	
	if Game.WINNER != "NONE":
		print("im gone fr yo")
		queue_free()		
	
		
func movement(left_key, right_key, delta):
	var upper_limit : int = 0
	var lower_limit : int = 800 
	if Input.is_action_pressed(left_key) && position.y >= upper_limit: 
		position += Vector2(0, -SPEED * delta)
		#print(DisplayServer.window_get_size())
	
	if Input.is_action_pressed(right_key) && position.y <= lower_limit: 
		position += Vector2(0, SPEED * delta)
		
		

func shoot():
	bullet_scene = preload("res://bullet.tscn")
	var b = bullet_scene.instantiate()
	b.player_type = PLAYER_TYPE
	get_tree().root.add_child(b)
	b.transform = $Marker2D.global_transform

func _on_timer_timeout():
	can_shoot = true

func _on_area_2d_area_entered(area):
	var tween = create_tween()
	# print("I collided with ")
	if health_component:
		health_component.take_damage()
		var health_size = health_component.health/10.0
		var x_multiplier = 1
		if PLAYER_TYPE == "ARW":
			x_multiplier = -1
		tween.tween_property($".", "scale", Vector2((health_size * x_multiplier),health_size), 0.2)
		
		# console text
		# var health_string : String = str(health_component.health)
		# print(health_string + "HP left for " + PLAYER_TYPE)
	
	# death condition
	if health_component.health <= 0:
		queue_free()
		


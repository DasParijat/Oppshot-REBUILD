extends CharacterBody2D

@export var PLAYER_TYPE = ""
@export var SPEED = 500
@export var bullet_scene : PackedScene
@export var health_component : Node2D 

var can_shoot : bool = true
var can_move : bool = true
var can_damaged : bool = true

var MAX_HEALTH = 10
var FRICTION = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.health = MAX_HEALTH
	match(PLAYER_TYPE):
		"WASD":
			self.scale = Vector2(1.5, 1.5)
			Game.WASD_alive = true
			$NewHdArrow.modulate = Game.WASD_color
		"ARW":
			self.scale = Vector2(-1.5, 1.5)
			Game.ARW_alive = true
			$NewHdArrow.modulate = Game.ARW_color
	

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
	if can_move:
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
	if health_component && can_damaged:
		health_component.take_damage()
		print(health_component.health)
		var health_size = (health_component.health/10.0) + 0.5
		print(health_size)
		var x_multiplier = 1
		if PLAYER_TYPE == "ARW":
			x_multiplier = -1
		tween.tween_property(self, "scale", Vector2((health_size * x_multiplier),health_size), 0.2)
	
	death_condition(tween)
		# console text
		# var health_string : String = str(health_component.health)
		# print(health_string + "HP left for " + PLAYER_TYPE)
		
func death_condition(tween):
	# death condition
	if health_component.health <= 0 && can_damaged:
		#use can_move to stop movement while player grows back to size
		#create timer to have more space between moving
		can_shoot = false
		can_move = false
		can_damaged = false
		tween.tween_property(self, "scale", Vector2(0,0), 0.2)
		#await tween.finished
		#$RespawnTimer.start()
		$NewHdArrow.self_modulate.a = 0.5
		match(PLAYER_TYPE):
			"WASD":
				position = Vector2(250 ,450)
				tween.tween_property(self, "scale", Vector2(1.5,1.5), 1)
				Game.WASD_alive = false
				print("wasd dead")
			"ARW":
				position = Vector2(923 ,450)
				tween.tween_property(self, "scale", Vector2(-1.5,1.5), 1)
				Game.ARW_alive = false
				print("arw dead")
		await tween.finished
		can_move = true
		$RespawnTimer.start()
		
func _on_respawn_timer_timeout():
	$NewHdArrow.self_modulate.a = 1
	can_shoot = true
	can_move = true
	can_damaged = true
	health_component.health = 10

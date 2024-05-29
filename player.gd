extends CharacterBody2D

@export var PLAYER_TYPE = ""
@export var SPEED = 500
@export var bullet_scene : PackedScene
@export var health_component : Node2D 

var can_shoot : bool = true
var can_move : bool = true
var can_damaged : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():	
	match(PLAYER_TYPE):
		"WASD":
			self.scale = Vector2(1.5, 1.5)
			Game.WASD_alive = true
			$NewHdArrow.modulate = Game.WASD_color
			$PointLight2D.set_color(Game.WASD_color)
		"ARW":
			self.scale = Vector2(-1.5, 1.5)
			Game.ARW_alive = true
			$NewHdArrow.modulate = Game.ARW_color
			$PointLight2D.set_color(Game.ARW_color)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement((PLAYER_TYPE + "_left"), (PLAYER_TYPE + "_right"), delta)
	
	# shooting
	if Input.is_action_just_pressed(PLAYER_TYPE + "_shoot") && can_shoot:
		can_shoot = false
		shoot()
		$ShootTimer.start()
	
	# deleting self before next round
	if Game.WINNER != "NONE":
		queue_free()	
		
func movement(left_key, right_key, delta):
	# both limits are 77 pixels away from the border
	var upper_limit : int = 77
	var lower_limit : int = 800 
	if can_move:
		if Input.is_action_pressed(left_key) && position.y >= upper_limit: 
			position += Vector2(0, -SPEED * delta)
		
		if Input.is_action_pressed(right_key) && position.y <= lower_limit: 
			position += Vector2(0, SPEED * delta)
		
func shoot():
	var bullet = preload("res://bullet.tscn").instantiate()
	bullet.player_type = PLAYER_TYPE
	bullet.transform = $Marker2D.global_transform
	get_tree().root.add_child(bullet)

func _on_timer_timeout():
	can_shoot = true

func _on_area_2d_area_entered(area):
	var tween = create_tween()
	if health_component && can_damaged:
		$hit_audio.play() 
		health_component.take_damage()
		
		# scaling variables for when health goes down
		var health_size = (health_component.health/5.0) + 0.5
		var x_multiplier : int
		match(PLAYER_TYPE):
			"WASD":
				x_multiplier = 1
			"ARW":
				x_multiplier = -1
		tween.tween_property(self, "scale", Vector2((health_size * x_multiplier),health_size), 0.2)
	
	death_condition(tween)
		
func death_condition(tween):
	if health_component.health <= 0 && can_damaged:
		$death_audio.play()
		
		can_shoot = false
		can_move = false
		can_damaged = false
		
		tween.tween_property(self, "scale", Vector2(0,0), 0.2)
		$NewHdArrow.self_modulate.a = 0.5
		
		match(PLAYER_TYPE):
			"WASD":
				position = Vector2(250, 450)
				tween.tween_property(self, "scale", Vector2(1.5,1.5), 1.5)
				Game.WASD_alive = false
			"ARW":
				position = Vector2(923, 450)
				tween.tween_property(self, "scale", Vector2(-1.5,1.5), 1.5)
				Game.ARW_alive = false
				
		await tween.finished
		can_move = true
		$RespawnTimer.start()
		
func _on_respawn_timer_timeout():
	$NewHdArrow.self_modulate.a = 1
	can_shoot = true
	can_damaged = true
	health_component.health = health_component.MAX_HEALTH


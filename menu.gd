extends Node2D

var time : float
# Called when the node enters the scene tree for the first time.
func _ready():
	#$"Play Message".material.set_shader_parameter("flash_modifier", 0.0)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# play_message_flash($"Play Message".self_modulate.a)
	time += delta
	$"Play Message".self_modulate.a = get_sine(5,0.25,0.75)
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://main_game.tscn")


#func _on_button_pressed():
	#get_tree().change_scene_to_file("res://main_game.tscn")
	

func _on_play_pressed():
	get_tree().change_scene_to_file("res://main_game.tscn")
	
func get_sine(f, a, b):
	# f = frequency
	# a = amount
	# b = base
	return (sin(time * f) * a) + b

	#print("flash off")
	#$"Play Message".material.set_shader_parameter("flash_modifier", 0.0)
	#flash()
	#$"Play Message/flash_timer".finished

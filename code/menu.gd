extends Node2D

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

var time : float
# Called when the node enters the scene tree for the first time.
func _ready():
	$SFXButtonSprite.play("audio_on")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	$"Play Message".self_modulate.a = get_sine(5,0.25,0.75)
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://main_game.tscn")
	
func get_sine(f, a, b):
	# f = frequency
	# a = amount
	# b = base
	return (sin(time * f) * a) + b

func _on_sfx_button_pressed():
	print("clicked")
	if $SFXButtonSprite.animation == "audio_off":
		$SFXButtonSprite.play("audio_on")
		AudioServer.set_bus_mute(SFX_BUS_ID, false)
	else:
		$SFXButtonSprite.play("audio_off")
		AudioServer.set_bus_mute(SFX_BUS_ID, true)
		

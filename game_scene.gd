extends Node2D

var ball_pitched = false
var baseball_scene = preload("res://baseball.tscn")  # Ensure the path is correct

func _ready():
	pitch_ball()

func _process(delta):
	if ball_pitched:
		spawn_baseball()

func spawn_baseball():
	# Check if baseball_scene is a valid PackedScene
	if baseball_scene:
		var baseball = baseball_scene.instantiate()  # Create an instance of the scene
		baseball.position = $Pitcher.position  # Adjust to actual pitcher node path
		add_child(baseball)
		ball_pitched = false

func pitch_ball():
	ball_pitched = true

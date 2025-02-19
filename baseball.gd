extends RigidBody2D

var pitch_select = 1
var ball_speed = 0  # Adjust the speed of the fastball

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if pitch_select == 1:
		pitch_fastball()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to throw a fastball straight down
func pitch_fastball():
	ball_speed = 300
	# Apply a downward impulse to the ball
	linear_velocity = Vector2(0, ball_speed)  # Apply a straight-down velocity
	# Optionally, you can use `apply_impulse()` for more realistic physics
	# apply_impulse(Vector2.ZERO, Vector2(0, fastball_speed))  # Impulse to go straight down

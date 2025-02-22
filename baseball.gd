extends RigidBody2D

@onready var batter = get_node("/root/GameScene/Batter")

var ball_hit = false

var pitch_select = 1
var ball_speed = 0  # Adjust the speed of the fastball
var hit_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if pitch_select == 1:
		pitch_fastball()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to throw a fastball straight down
func pitch_fastball():
	ball_speed = randi_range(800, 1200)
	# Apply a downward impulse to the ball
	linear_velocity = Vector2(0, ball_speed)  # Apply a random Y velocity

	# Optionally, you can use `apply_impulse()` for more realistic physics
	# apply_impulse(Vector2.ZERO, Vector2(0, fastball_speed))  # Impulse to go straight down

func _on_ball_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bat") and not ball_hit:
		# Get the bat's angle in degrees
		var bat_angle = batter.bat_pivot.rotation_degrees - 45
		
		# Convert the angle to radians (since Godot's trig functions use radians)
		var angle_in_radians = deg_to_rad(bat_angle)
		
		# Create a direction vector based on the angle
		var direction = Vector2(cos(angle_in_radians), sin(angle_in_radians))
		
		var hit_speed = ball_speed * 1.1
		
		# Scale the direction by the desired speed (500 in this case)
		linear_velocity = direction * hit_speed
		
		ball_hit = true
		
		print("Ball hit, Bat angle: ", bat_angle)

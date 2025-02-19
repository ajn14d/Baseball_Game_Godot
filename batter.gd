extends RigidBody2D

@onready var bat_pivot = $BatPivot  # Pivot Node2D (rotates like a clock hand)

var swinging := false

func _input(event):
	if event.is_action_pressed("swing") and not swinging:
		swing_bat()

func swing_bat():
	swinging = true
	var tween = create_tween()

	# Rotate the pivot instead of the bat itself
	tween.tween_property(bat_pivot, "rotation_degrees", -90, 0.1)  # Counterclockwise swing (6 to 12)
	tween.tween_property(bat_pivot, "rotation_degrees", 135, 0.1).set_delay(0.1)  # Reset after delay

	tween.finished.connect(func(): swinging = false)  # Reset swing flag

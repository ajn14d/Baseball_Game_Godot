extends RigidBody2D

@onready var bat_pivot = $BatPivot  # Pivot Node2D (rotates like a clock hand)

var bat_angle = 0

var swinging := false
var swing_speed := 0.3  # The speed of the swing (lower value = faster swing)

func _input(event):
	if event.is_action_pressed("swing") and not swinging:
		swing_bat()

func swing_bat():
	swinging = true
	var tween = create_tween()

	# Rotate the pivot instead of the bat itself
	tween.tween_property(bat_pivot, "rotation_degrees", -90, swing_speed)  # Counterclockwise swing (6 to 12)
	tween.tween_property(bat_pivot, "rotation_degrees", 135, swing_speed).set_delay(0.5)  # Reset after delay

	tween.finished.connect(func(): swinging = false)  # Reset swing flag

func _on_bat_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ball"):
		bat_angle = bat_pivot.rotation_degrees

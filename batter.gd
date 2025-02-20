extends RigidBody2D

@onready var bat_pivot = $BatPivot  # Pivot Node2D (rotates like a clock hand)
@onready var bat_sprite = $BatPivot/BatSprite  # Reference to BatSprite
@onready var bat_collision = $BatPivot/BatArea/CollisionShape2D  # Reference to BatArea (collision shape)

var bat_angle = 0
var swinging := false
var swing_speed := 0.25  # The speed of the swing (lower value = faster swing)

func _input(event):
	if event.is_action_pressed("swing") and not swinging:
		swing_bat()

func swing_bat():
	swinging = true
	var tween = create_tween()
	tween.set_parallel(true)  # Make all tweens run at the same time

	# Rotate the pivot (main swing motion)
	tween.tween_property(bat_pivot, "rotation_degrees", -90, swing_speed)  # Counterclockwise swing (6 to 12)
	
	# Add wrist movement by slightly rotating the BatSprite and BatArea
	tween.tween_property(bat_sprite, "rotation_degrees", 75, swing_speed).set_delay(0.01)
	tween.tween_property(bat_collision, "rotation_degrees", 75, swing_speed).set_delay(0.01) 

	# Reset rotation after delay
	tween.tween_property(bat_pivot, "rotation_degrees", 150, swing_speed).set_delay(0.5)  # Reset bat pivot
	tween.tween_property(bat_sprite, "rotation_degrees", 150, swing_speed).set_delay(0.5)  # Reset wrist movement
	tween.tween_property(bat_collision, "rotation_degrees", 150, swing_speed).set_delay(0.5)  # Reset collision shape

	tween.finished.connect(func(): swinging = false)  # Reset swing flag

func _on_bat_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ball"):
		bat_angle = bat_pivot.rotation_degrees

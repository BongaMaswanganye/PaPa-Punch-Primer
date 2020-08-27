extends KinematicBody2D
class_name Player_1

export var speed = Vector2(300.0, 1000.0)
export var gravity = 3000.0
const FLOOR_NORMAL = Vector2.UP

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = max(velocity.y, speed.y)
	
	direction = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("p1_right") - Input.get_action_strength("p1_left"), 
		-1.0 if Input.is_action_just_pressed("p1_jump") and is_on_floor() else 1.0
	)


func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
) -> Vector2:
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	return new_velocity

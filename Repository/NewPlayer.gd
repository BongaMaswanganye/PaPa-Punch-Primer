extends KinematicBody2D

export var Health = 100
export var run_speed = 300
export var jump_speed = -1100
export var gravity = 2500

var velocity = Vector2()
var jumping = false
onready var ANI = get_node("AnimatedSprite")

func get_input():
	velocity.x = 0
	
	var right = Input.is_action_pressed("p1_right")
	var left = Input.is_action_pressed("p1_left")
	var jump = Input.is_action_just_pressed("p1_jump")
	var attack_1 = Input.is_action_just_pressed("p1_attack")
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed
	if attack_1:
		$AnimatedSprite.play("Attack-1")
		
		
		
	
		
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("Idle")

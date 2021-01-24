extends KinematicBody2D

export var Health = 80
export var maxHealth = 100
export var run_speed = 300
export var jump_speed = -1100
export var gravity = 2500


var velocity = Vector2()
var jumping = false
var state_machine


signal damaged
signal newHealth
signal newMaxHP

func _ready():
	initialize()
	state_machine = $AnimationTree.get("parameters/playback")
	

func get_input():
	var current_anim = state_machine.get_current_node()
	
	velocity.x = 0
	
	var right = Input.is_action_pressed("p1_right")
	var left = Input.is_action_pressed("p1_left")
	var jump = Input.is_action_just_pressed("p1_jump")
	var attack_1 = Input.is_action_just_pressed("p1_attack")


	if Input.is_action_just_pressed("damaged"):
		damaged()
		
	if attack_1:
		print("Attack 1")
		state_machine.travel("Attack1")
		# REMEMBER TO PUT RETURN IN THINGS THAT DO NOT AUTOMATICALLY TERMINATE
		return
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed
		
	if velocity.length() == 0:
		state_machine.travel("Idle")
		
	if velocity.length() > 0:
		state_machine.travel("Walk")

# make a separate code block/function to deal with state machine travel

	

func damaged():
		Health -= 10
		Health = clamp (Health, 0, maxHealth)
		print("G was pressed, [NewPlayer.gd]")
		print("Health: ", Health)
		print("maxHealth: ", maxHealth)
		emit_signal("damaged", Health)
		

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))


func initialize():
	Health = maxHealth
	emit_signal("newHealth", Health)
	emit_signal("newMaxHP", maxHealth)
	


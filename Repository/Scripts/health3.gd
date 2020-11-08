extends Node

export(int) var health = 100;
onready var health_bar = get_node("health_bar")

func _ready():
	health_bar.max_value = health
	health_bar.value = health

func _physics_process(_delta):
	health_bar.value = health
	if Input.is_action_just_released("damaged"):
		health -= 1
	if health < 0:
		health = 0




"""
signal max_changed(new_max)
signal changed(new_amount)
signal depleted


# Attach values to current/values on progress bar
# _on_Player_damaged(), works, can send values
# set_current has some fuckery, recombine for altering bar values
# "current" and "max_amount" are able to be changed through signals.

export(int) var health = 100;
onready var health_bar = get_node("health_bar1")

# new methods

# called to create the scene
func _ready():
	_initialize()

# called to construct the scene
func _initialize():
	emit_signal ("max_changed", max_amount)
	emit_signal ("changed", current)
	health_bar.max_value = health
	health_bar.value = health


func _physics_process(_delta):
	health_bar.value = health
	if Input.is_action_just_released("damaged"):
		health -= 1
	if health < 0:
		health = 0



# Encapsulates variables so that third-party actions trigger the methods within THIS code instead of other code
export(int) var max_amount = 100 setget set_max
onready var current = max_amount setget set_current


### Methods

func _ready():
	_initialize()

#function sets max health on initializtion to prevent default values
# max_amount ensures health values are always AT LEAST above 1
func set_max(new_max):
	max_amount = max(1, new_max);
	emit_signal ("max_changed", max_amount);

#function updates health values as signal is recieved to change
#clamp used so that health values are never below 0 or above max health
func set_current(_new_hpVal):
	current = clamp(current, 0, max_amount)
	emit_signal ("changed", current)
	
	if current == 0:
		emit_signal ("depleted")
	
	print("It worked.")
	print("Max amount: ", max_amount)
	print("Current: ", current)


func _initialize():
	emit_signal ("max_changed", max_amount)
	emit_signal ("changed", current)

"""

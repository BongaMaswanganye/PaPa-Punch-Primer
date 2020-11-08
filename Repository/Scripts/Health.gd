extends Node

#signals for observation

signal max_changed(new_max)
signal changed(new_value)
signal depleted

# setgets: force external functions that change these variables to run the change through the setget function
##  i.e. if an external function alters max_amount, the set_max function will still apply to the max_amount
# some naming convention bullshit

export(int) var max_amount = 100 setget set_max
onready var current = max_amount setget set_current

func ready():
	_initialize()

func set_max(new_max):
	max_amount = max(1, new_max)
	emit_signal ("max_changed", max_amount)
	
func set_current(new_value):
	current = clamp (current, 0, max_amount)
	emit_signal ("changed", current)
	
	if current == 0:
		emit_signal ("depleted")
		

func _initialize():
	emit_signal ("max_changed", max_amount)
	emit_signal ("changed", current)

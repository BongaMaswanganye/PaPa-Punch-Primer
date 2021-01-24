extends Node2D

onready var startup_timer = $Startup
onready var duration_timer = $Duration
onready var cooldown_timer = $Cooldown

export (float) var startup = 0.1		# startup frames
export (float) var duration = 0.1		# active frames
export (float) var cooldown = 0.1		# recovery frames

func execute():
	#if not enabled:
	#	return
	# Checking if the cooldown is stopped (i.e. move is done recovering)
	if not cooldown_timer.is_stopped():
		return
	cooldown_timer.start(cooldown)
	duration_timer.start(duration)
	emit_signal("started")
	

func cancel():
	#if not enabled:
	#	return
	if duration_timer.is_stopped():
		return
	duration_timer.stop()
	emit_signal("finished")
	

func _on_Duration_Timeout():
	#if not enabled:
	#	return
	emit_signal("finished")
		

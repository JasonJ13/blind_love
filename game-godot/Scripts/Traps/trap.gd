@abstract class_name Trap 
extends StaticBody2D

signal activation_signal
signal desactivation_signal

var active : bool 

func is_actived() -> bool :
	return active

func activate():
	activation_signal.emit()
	active = true

func desactivate() -> void :
	desactivation_signal.emit()
	active = false

@abstract func activation()
@abstract func desactivation()

class_name Trap extends StaticBody2D

signal activation
signal desactivation

signal contact

var active = true


func is_actived() -> bool :
	return active

func desactivate() -> void :
	active = false
	desactivation.emit()

func activate():
	active=true
	activation.emit()

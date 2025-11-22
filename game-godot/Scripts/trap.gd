class_name Trap extends StaticBody2D

signal activation
signal desactivation

var active:bool 

func is_actived() -> bool :
	return active

func desactivate() -> void :
	if is_actived() :
		desactivation.emit()
	
	active = false
	

func activate():
	if !is_actived() :
		activation.emit()
	
	active=true

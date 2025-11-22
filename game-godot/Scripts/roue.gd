extends StaticBody2D
class_name Roue

signal is_actived_signal

var actived : bool = false

func is_actived() -> bool :
	return actived

func active() -> void :
	actived = true
	is_actived_signal.emit()

func desactive() -> void :
	actived = false

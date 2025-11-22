extends StaticBody2D
class_name Roue

signal is_actived_signal

var actived : bool = false
@export var sprite : AnimatedSprite2D

func is_actived() -> bool :
	return actived

func active() -> void :
	actived = true
	sprite.play()
	$AudioStreamPlayer2D.play()
	is_actived_signal.emit()

func desactive() -> void :
	actived = false
	$AudioStreamPlayer2D.stop()
	sprite.stop()
	sprite.frame = 0

extends StaticBody2D
class_name Roue

signal is_actived_signal

var actived : bool = false
var resolve : bool = false
@export var sprite : AnimatedSprite2D

func is_actived() -> bool :
	return actived

func active() -> void :
	if !resolve :
		actived = true
		sprite.play()
		$AudioStreamPlayer2D.play()
		is_actived_signal.emit()

func desactive() -> void :
	actived = false
	$AudioStreamPlayer2D.stop()
	sprite.stop()
	sprite.frame = 0

func all_active() -> void :
	resolve = true
	$AudioStreamPlayer2D.stop()
	sprite.stop()
	sprite.frame = 1

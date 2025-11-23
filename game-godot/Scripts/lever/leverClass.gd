extends StaticBody2D
class_name Lever

signal is_actived_signal

var actived : int = 0
var resolve : bool = false


@export var wires : Array[ColorRect]

func _ready() -> void:
	for wire in wires :
		wire.color = Color(0.3,0.3,0.3)

func is_actived() -> bool :
	return actived > 0

func activation() -> void :
	if !resolve :
		if !is_actived() :

			for wire in wires :
				wire.color = Color(0.302, 0.835, 0.302, 1.0)
		
		actived += 1
		is_actived_signal.emit()

func desactivation() -> void :
	if !resolve :
		actived -= 1
		if !is_actived() :
			
			for wire in wires :
				wire.color = Color(0.3,0.3,0.3)

func all_activation() -> void :
	resolve = true

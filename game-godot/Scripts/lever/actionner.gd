@abstract class_name  Actionner
extends StaticBody2D


signal is_actived_signal

var actived : int = 0			# Number of person on the lever, 0 -> desactivated, 1+ -> activated
var resolve : bool = false		# All the actionner of the same group is actived, will not disactivate

@abstract func activation()
@abstract func desactivation()

@export var wires : Array[ColorRect]	#Visual indication to the door

func _ready() -> void:
	for wire in wires :
		wire.color = Color(0.3,0.3,0.3)	#Les actionneurs commances éteints, on désactive tout les fils

func is_actived() -> bool :
	return actived > 0

func active() -> void :
	if !is_actived() :
		activation()
		
		for wire in wires :
			wire.color = Color(0.302, 0.835, 0.302, 1.0)		#	Activation des fils
	
	actived += 1
	is_actived_signal.emit()


func desactive() -> void :
		actived -= 1
		
		if !is_actived() :
			desactivation()
			
			for wire in wires :
				wire.color = Color(0.3,0.3,0.3)					# Désactivation des fils


func as_resolve() -> void :
	resolve = true
	for wire in wires :
		wire.color = Color(0.302, 0.835, 0.302, 1.0)				# Activation des fils

func is_resolve() -> bool :
	return resolve

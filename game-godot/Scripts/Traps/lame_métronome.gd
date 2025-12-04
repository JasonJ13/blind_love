extends Trap

@export var begin_active : bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if begin_active :
		activate()
	else :
		desactivate()


func activation() :
	pass

func desactivation() :
	pass

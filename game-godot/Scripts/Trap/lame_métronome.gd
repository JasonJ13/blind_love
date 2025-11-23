class_name Lame extends Trap
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active=true




func play_radar(act):
	if act:
		animated_sprite_2d.show()
	else :
		animated_sprite_2d.hide()
			

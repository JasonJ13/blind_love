extends Actionner
class_name Roue

@onready var sprite : AnimatedSprite2D = $Sprite
@onready var sound : AudioStreamPlayer2D = $AudioStreamPlayer2D


func ready() -> void :
	sprite.frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func activation() -> void:
	sprite.play()
	sound.play()
	


func desactivation() -> void :
	sound.stop()
	sprite.stop()
	sprite.frame = 0

func all_active() -> void :
	sound.stop()
	sprite.stop()
	sprite.frame = 1
	as_resolve()

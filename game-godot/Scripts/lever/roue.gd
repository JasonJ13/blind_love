extends Lever

@export var sprite : AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func active() -> void:
	if !is_actived() :
		sprite.play()
		$AudioStreamPlayer2D.play()
	
	activation()

func desactive() -> void :
	desactivation()
	if !is_actived() :
		$AudioStreamPlayer2D.stop()
		sprite.stop()
		sprite.frame = 0

func all_active() -> void :
	$AudioStreamPlayer2D.stop()
	sprite.stop()
	sprite.frame = 1
	all_activation()

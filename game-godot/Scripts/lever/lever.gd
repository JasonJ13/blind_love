extends Lever

@onready var bar : ColorRect = $bar
@onready var progress_an : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _ready() -> void:
	bar.hide()

func begin_bar() -> void :
	bar.show()
	sprite.frame = 1
	progress_an.play("progress")

func stop_bar() -> void :
	progress_an.stop()
	bar.hide()
	

func active() -> void:
	if !resolve :
		begin_bar()

func desactive() -> void:
	if !resolve :
		stop_bar()
		sprite.frame = 0
	

@warning_ignore("unused_parameter")
func end_active(animation) -> void :
	activation()
	sprite.frame = 2
	resolve = true
	bar.hide()
	print("activate")

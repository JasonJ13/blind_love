extends Actionner

@onready var bar : ColorRect = $bar
@onready var progress_an : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D


func _ready() -> void:
	bar.hide()
	sprite.frame = 0

func begin_bar() -> void :
	bar.show()
	sprite.frame = 1
	progress_an.play("progress")

func stop_bar() -> void :
	print("stop")
	progress_an.stop()
	sprite.frame = 0
	bar.hide()


func activation() -> void:
	begin_bar()

func desactivation() -> void:
	stop_bar()
	

@warning_ignore("unused_parameter")
func end_bar(animation) -> void :
	as_resolve()
	sprite.frame = 2
	bar.hide()

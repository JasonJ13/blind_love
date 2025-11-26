class_name Pics extends Trap


@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var sound : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	desactivate()


func activation():
	sprite.play("picsOn")
	sound.play()

func desactivation():
	sprite.play("picsOff")

func step_on(body : CharacterBody2D) :
	
	if body is Princess || body is Knight :
		activate()

func step_off(body : CharacterBody2D) :
	if body is Princess || body is Knight :
		desactivate()

class_name Pics extends Trap
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	active=false
	sprite.play("picsOff")

func _on_zone_detection_body_entered(_body: Node2D) -> void:
	sprite.play("picsOn")
	$AudioStreamPlayer2D.play()
	activate()

func play_radar(act):
	if active:
		animated_sprite_2d_2.show()
	else :
		animated_sprite_2d_2.hide()

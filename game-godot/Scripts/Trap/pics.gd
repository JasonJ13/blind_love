class_name Pics extends Trap


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	active=false
	sprite.play("picsOff")

func _on_zone_detection_body_entered(_body: Node2D) -> void:
	sprite.play("picsOn")
	activate()

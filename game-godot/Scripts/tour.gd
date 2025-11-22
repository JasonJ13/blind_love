class_name Tour extends Trap


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var cibles: Array[CharacterBody2D]
var current_cible:CharacterBody2D



func _ready() -> void:
	active=false

func _process(_delta:float):
	if active:
		pass

func _on_zone_detection_body_entered(body: Node2D) -> void:
	activate()
	if body is CharacterBody2D:
		cibles.append(body)
	current_cible=cibles[0]




func _on_zone_detection_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		cibles.erase(body)
	if len(cibles)==0:
		desactivate()
		sprite.play("sleep")
	else :
		current_cible=cibles[0]

class_name Tour extends Trap


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var cibles: Array[CharacterBody2D]
var current_cible:CharacterBody2D



func _ready() -> void:
	active=false

func _process(_delta:float):
	if active:
		var regard = global_position-current_cible.global_position
		var angle = rad_to_deg(regard.angle())
		print(angle)
		#méthode de galérienne car je sais pas utilser animation player
		if angle>-15 and angle<40:
			sprite.play("left90")
		elif angle<-165 or angle>140:
			sprite.play("right90")
		elif angle>0:
			sprite.play("back")
		elif angle<-75 and angle>-105:
			sprite.play("front")
		elif angle<-15 and angle>-100:
			sprite.play("left45")
		else:
			sprite.play("right45")

func _on_zone_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		activate()
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

extends CharacterBody2D

@export var princesse : CharacterBody2D
var radius_princesse : int

@export var radius_center : int = 12
@onready var center : CollisionShape2D = $center

@onready var label = $Label
var nmb_hear : int = 0

func set_princesse(pr : CharacterBody2D, radius : int) -> void :
	princesse = pr
	radius_princesse = radius


func follow() -> void :
	
	var angle_princesse = get_angle_to(princesse.position)
	position.x = princesse.position.x - radius_princesse*cos(angle_princesse)
	position.y = princesse.position.y - radius_princesse*sin(angle_princesse)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center.shape.radius = radius_center


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func hear_something(body: Node2D) -> void:
	
	
	if (body is Trap && body.is_actived()) :
		label.show()
		nmb_hear += 1
		
		#body.desactivation.connect("Deaf_bruh",body)


func Deaf_bruh(body: Node2D) -> void:
	
	if (body is Trap && body.is_actived()) :
		nmb_hear -= 1
		
		if nmb_hear == 0 :
			label.hide()

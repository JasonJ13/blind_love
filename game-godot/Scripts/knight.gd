extends CharacterBody2D

var princesse : CharacterBody2D
var radius_princesse : int


func set_princesse(pr : CharacterBody2D, radius : int) -> void :
	princesse = pr
	radius_princesse = radius


func follow() -> void :
	
	var angle_princesse = get_angle_to(princesse.position)
	position.x = princesse.position.x - radius_princesse*cos(angle_princesse)
	position.y = princesse.position.y - radius_princesse*sin(angle_princesse)
	print(position.distance_to(princesse.position))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

extends CharacterBody2D


const SPEED = 300.0


@export var area_pull_radius : int = 128
@onready var area_pull : Area2D = $Area2D
@onready var area_pull_collision : CollisionShape2D = $Area2D/CollisionShape2D

var knight : CharacterBody2D

func _ready() -> void :
	area_pull_collision.shape.radius = area_pull_radius


func set_knight(kn : CharacterBody2D) :
	knight = kn

func get_radius() -> int :
	return area_pull_radius

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up","ui_down")
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()




func get_over_here(body: Node2D) -> void:
	#If the knight leave, make it pull closer
	if body == knight :
		body.follow()

extends CharacterBody2D


const SPEED = 300.0


@export var area_pull_radius : int = 128

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var old_direction = 'down'
var new_direction = 'down'

@export var knight : CharacterBody2D
var is_following : bool = true
var is_close : bool = true

func _ready() -> void :
	pass

func set_knight(kn : CharacterBody2D) :
	knight = kn

func get_radius() -> int :
	return area_pull_radius

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:

	### Princesse Mouvement
	var directionX := Input.get_axis("Left", "Right")
	var directionY := Input.get_axis("Up","Down")
	if directionX:
		velocity.x = directionX
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if directionY:
		velocity.y = directionY
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	velocity = velocity.normalized() * SPEED
	move_and_slide()
	
	
	### Princess Sprite
	
	if velocity == Vector2(0,0) :
		sprite.frame = 0
		sprite.stop()
	
	else :
		
		if abs(velocity.x) > abs(velocity.y) :
			if velocity.x > 0 :
				new_direction = 'right'
			else :
				new_direction = 'left'
		else :
			if velocity.y > 0 :
				new_direction = 'down'
			else :
				new_direction = 'up'
		
		if new_direction != old_direction :
			sprite.play(new_direction)
			old_direction = new_direction
	
	
	### Mouvement Knight
	if Input.is_action_just_pressed("ui_accept") && is_close:
		is_following = !is_following
	
	is_close = position.distance_to(knight.position) < area_pull_radius +.01
	
	if knight && is_following && !is_close :
		knight.follow()
		is_close = true

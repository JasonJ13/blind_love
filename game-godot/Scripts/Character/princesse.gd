extends CharacterBody2D


@export var SPEED = 300.0


@export var area_pull_radius : int = 128

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var old_direction = 'down'
var new_direction = 'down'

@onready var sound_hold : AudioStreamPlayer2D = $HoldStreamPlayer2D
@onready var sound_let : AudioStreamPlayer2D = $LetStreamPlayer2D

@export var knight : CharacterBody2D
var is_following : bool = true
var is_close : bool = true

var lever_present : Roue = null

@export var light : bool = true


func _ready() -> void :
	if light :
		$PointLight2D.show()

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
	
	if position.y > knight.position.y :
		z_index = 1
		knight.z_index = 0
	else :
		z_index = 0
		knight.z_index = 1
	
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
	
	
	### Activate roue
	
	if lever_present :
		if Input.is_action_just_pressed("ui_select") :
			lever_present.active()
			SPEED = 0
		elif Input.is_action_just_released("ui_select") :
			if lever_present is Roue :
				lever_present.desactive()
			SPEED = 200
	
	
	
	### Mouvement Knight
	var O1 = Input.is_action_just_pressed("Order 1")
	var O2 = Input.is_action_just_pressed("Order 2")
	if (O1 || O2) && is_close:
		
		if !is_following :
			sound_hold.play()
			is_following = true
			knight.drop_lever()
		
		else :
			if O1 :
				is_following = false
				sound_let.play()
			
			elif O2 && lever_present :
				knight.go_to_lever(lever_present)
				is_following = false
	
	is_close = position.distance_to(knight.position) < area_pull_radius +.01
	
	if knight && is_following && !is_close :
		knight.follow()
		is_close = true


func lever_reach(body: Node2D) -> void:
	if body is Roue :
		lever_present = body


func lever_leave(body: Node2D) -> void:
	if body == lever_present :
		lever_present = null

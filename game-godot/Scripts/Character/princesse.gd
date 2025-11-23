extends CharacterBody2D


@export var SPEED = 300.0


@export var area_pull_radius : int = 128

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var old_direction = null
var new_direction = null

@onready var sound_hold : AudioStreamPlayer2D = $HoldStreamPlayer2D
@onready var sound_let : AudioStreamPlayer2D = $LetStreamPlayer2D

@export var knight : CharacterBody2D
var is_following : bool = true
var is_close : bool = true

@export var range_max_rope : int = 256 

var lever_present : Roue = null

@export var light : bool = true

var input_disabled=false


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
	
	
	var distance_kn = position.distance_to(knight.position)
	var angle_kn = knight.position.angle_to_point(position)
	

	var opposite = directionY * sign(angle_kn) > 0 || (directionX == 1 && abs(angle_kn) < PI/2) || (directionX == -1 && abs(angle_kn) > PI/2)

	@warning_ignore("integer_division")
	if distance_kn > range_max_rope*3/4 && opposite :
		velocity = velocity * ((abs(range_max_rope - distance_kn)) / range_max_rope )
	
	if input_disabled:
		velocity=Vector2.ZERO
	move_and_slide()
	
	
	
	### Princess Sprite
	
	if velocity == Vector2(0,0) :
		sprite.frame = 0
		sprite.stop()
	
	else :
		move_rope(distance_kn, angle_kn)
		
		if position.y > knight.position.y :
			z_index = 1
			knight.z_index = 0
		else :
			z_index = 0
			knight.z_index = 1
		
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
	
	if knight && is_following && !is_close && !input_disabled :
		knight.follow()
		is_close = true


func lever_reach(body: Node2D) -> void:
	if body is Roue :
		lever_present = body


func lever_leave(body: Node2D) -> void:
	if body == lever_present :
		lever_present = null

func play_animation(anim):
	sprite.play(anim)

func stop_animation():
	sprite.frame=0


@onready var rope = $Rope

func move_rope(distance_kn : float, angle_kn : float) -> void :
	
	rope.rotation = angle_kn + PI/2
	rope.size.y = distance_kn *2
	
	
	

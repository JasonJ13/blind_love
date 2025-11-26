extends CharacterBody2D
class_name Knight


@onready var center : CollisionShape2D = $center

@onready var label = $Label
var nmb_hear : int = 0

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var is_moving : bool = false
var old_direction : String = "down"
var new_direction : String = "down"
@onready var timer_moving : Timer = $Moving

@export var princesse : CharacterBody2D
var radius_princesse : int


@export var SPEED : float = 200


func set_princesse(pr : CharacterBody2D, radius : int) -> void :
	princesse = pr
	radius_princesse = radius


func follow() -> void :
	
	var angle_princesse = get_angle_to(princesse.position)
	var distance_princess = Vector2(radius_princesse*cos(angle_princesse),radius_princesse*sin(angle_princesse))
	position.x = princesse.position.x - distance_princess.x
	position.y = princesse.position.y - distance_princess.y
	
	mouvement_detection(distance_princess)
	timer_moving.start()


func mouvement_detection(distance_objective : Vector2) -> void :
		
	
	if abs(distance_objective.x) > abs(distance_objective.y) :
		if distance_objective.x > 0 :
			new_direction = "right"
			
		else :
			new_direction = "left"
			
	else :
		if distance_objective.y > 0 :
			new_direction = "down"
		else :
			new_direction = "up"
	
	if new_direction != old_direction || !is_moving :
		sprite.play(new_direction)
		old_direction = new_direction
		is_moving = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_princesse(princesse,princesse.get_radius())

func play_animation(anim):
	sprite.play(anim)
	
func stop_anim():
	sprite.frame=0
	sprite.stop()

func remove_one_trap() -> void :
	nmb_hear -= 1
		
	if nmb_hear == 0 :
		label.hide()

func add_one_trap() -> void :
	if nmb_hear == 0 :
		label.show()
	
	nmb_hear += 1
	


func hear_something(body: Node2D) -> void:
	
	
	if (body is Trap) :
		
		if (body.is_actived()) :
			add_one_trap()
		
		body.desactivation.connect(self.remove_one_trap)
		body.activation.connect(self.add_one_trap)


func Deaf_bruh(body: Node2D) -> void:
	
	if (body is Trap) :
		
		if body.is_actived() :
			remove_one_trap()
			
		body.desactivation.disconnect(self.remove_one_trap)
		body.activation.disconnect(self.add_one_trap)


func stop() -> void:
	sprite.stop()
	sprite.frame = 0
	is_moving = false




var actionner : Actionner
var not_reach : bool = true

func go_to_lever(a : Actionner) :
	actionner = a

func drop_lever() :
	if actionner : 
		if! actionner.is_resolve() :
			actionner.desactive()
		
		actionner = null
		not_reach = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	if actionner && not_reach:
		var direction = actionner.position - position
		velocity = direction.normalized() * SPEED
		
		move_and_slide()
		princesse.move_rope(position.distance_to(princesse.position),get_angle_to(princesse.position))
		
		if position.distance_to(actionner.position) < 64 :
			lever_reach(actionner)


func lever_reach(body: Node2D) -> void:
	
	if actionner && body == actionner :
		not_reach = false
		actionner.active()
	



###MORT

signal dead

func die() -> void :
	dead.emit()


func trap_leave(body: Node2D) -> void:
	if body is Trap :
		body.activation_signal.disconnect(die)


func hitbox_enter(body: Node2D) -> void:
	if body is Trap :
		body.activation_signal.connect(die)
		if body.is_actived() :
			die()


func hitbox_exit(body: Node2D) -> void:
	if body is Trap :
		body.activation_signal.disconnect(die)

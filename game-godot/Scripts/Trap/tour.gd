class_name Tour extends Trap


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var lumiere: RayCast2D = $Lumière

var cibles: Array[CharacterBody2D]
var current_cible:CharacterBody2D

var cible_in_sight=false
var attack_delay=4
enum STATE{SLEEP,WATCH,ATTACK}
var current_state=STATE.SLEEP
var timer:Timer = Timer.new()

func _ready() -> void:
	active=false
	add_child(timer)
	timer.timeout.connect(self.change_state.bind(STATE.ATTACK))

func _process(_delta:float):
	match current_state:
		STATE.SLEEP:
			lumiere.is_casting=false
			lumiere.current_state=lumiere.STATE.rest
			lumiere.hide()
			if len(cibles)>0:
				for c in cibles:
					sight_check(c)
					if cible_in_sight:
						current_cible=c
						change_state(STATE.WATCH)
						pass
		STATE.WATCH:
			
			sight_check(current_cible)
			if cible_in_sight:
				var regard = global_position-current_cible.global_position
				var angle = rad_to_deg(regard.angle())
				lumiere.direction=regard
				lumiere.is_casting=true
				lumiere.current_state=lumiere.STATE.charge
				lumiere.show()

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
				current_cible=cibles[0]
			elif len(cibles)>1:
				current_cible=cibles[1]
				sight_check(current_cible)
				if !cible_in_sight:
					change_state(STATE.SLEEP)
			else:
				change_state(STATE.SLEEP)
		STATE.ATTACK:
			sight_check(current_cible)
			if cible_in_sight:
				var regard = global_position-current_cible.global_position
				var angle = rad_to_deg(regard.angle())
				lumiere.direction=regard
				lumiere.is_casting=true
				lumiere.current_state=lumiere.STATE.attaque
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
				current_cible=cibles[0]
			elif len(cibles)>1:
				current_cible=cibles[1]
				sight_check(current_cible)
				if !cible_in_sight:
					change_state(STATE.SLEEP)
			else:
				change_state(STATE.SLEEP)
	

func sight_check(body:CharacterBody2D):
	
	var space_state=get_world_2d().direct_space_state
	var sightParameters=PhysicsRayQueryParameters2D.create(global_position,body.global_position,collision_mask,[self])
	var sight=space_state.intersect_ray(sightParameters)
	if len(sight)>0 and sight["collider"] is CharacterBody2D :
		cible_in_sight=true
	else:
		cible_in_sight=false
		
func change_state(state):
	current_state=state
	if current_state==STATE.WATCH:
		timer.start(attack_delay)
	if current_state!=STATE.WATCH:
		timer.stop()

func sleep():
	desactivate()
	sprite.play("sleep")
	lumiere.is_casting=false

func _on_zone_detection_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		cibles.append(body)
		current_cible=cibles[0]
		sight_check(body)
		if cible_in_sight:
			change_state(STATE.WATCH)
			activate()


func _on_zone_detection_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		cibles.erase(body)
		if len(cibles)==0:
			change_state(STATE.SLEEP)
			sleep()
		else :
			current_cible=cibles[0]

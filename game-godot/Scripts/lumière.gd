extends RayCast2D

@export var cast_speed = 0.01 #bruh
@export var max_length = 400

@onready var line_2d: Line2D = $Line2D
@onready var charge_audio: AudioStreamPlayer = $charge
@onready var attaque_audio: AudioStreamPlayer = $attaque

var direction:Vector2

enum STATE{charge,attaque,rest}

var current_state:STATE
var played_charge=false
var is_casting=false

func _physics_process(delta: float) -> void:
	match current_state:
		STATE.charge:
			if !charge_audio.is_playing() and !played_charge:
				charge_audio.play()
				played_charge=true
			line_2d.default_color=Color.WHITE
		STATE.attaque:
			line_2d.default_color=Color.DARK_RED
			if !attaque_audio.is_playing():
				attaque_audio.play()
		STATE.rest:
			charge_audio.stop()
			played_charge=false
	if direction:
		target_position=(target_position.normalized()-direction)
		target_position.x=move_toward(target_position.x,
		max_length,
		cast_speed*delta)
		
	line_2d.points[1]=target_position
	if !is_casting:
		target_position.x=0
	

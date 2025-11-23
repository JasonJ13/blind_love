extends Node2D

@onready var princesse: CharacterBody2D = $Princesse
@onready var knight: CharacterBody2D = $Knight
@onready var dialogue_box: Textbox = $dialogue_box

var flag1=false
var flag2=false
var flag3=false

func _ready() -> void:
	princesse.input_disabled=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !flag1:
		princesse.velocity=princesse.SPEED *Vector2.LEFT
		princesse.play_animation("left")
		princesse.move_and_slide()
		if distance(princesse.global_position-knight.global_position)<100:
			flag1=true
			princesse.stop_animation()
			dialogue_box.active=true

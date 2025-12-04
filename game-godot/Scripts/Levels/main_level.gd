extends Node2D

@onready var princess : Princess = $Princesse
@onready var knight : Knight = $Knight
@onready var death : CanvasLayer = $death

@export var nmb_level : int = 1
var levels : Array[Resource]
var current_nmb_level : int = 0
var current_level : Level = null

signal go_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in range (nmb_level) :
		levels.append(load("res://Scenes/level/Lvl"+str(n+1)+".tscn"))
	
	new_level()
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func new_level() -> void :
	
	if current_level :
		current_level.queue_free()
	
	current_level = levels[current_nmb_level].instantiate()
	current_level.level_end.connect(finished_level)
	
	call_deferred("add_child", current_level)
	
	current_level.spawn(princess, knight)
	princess.spawn()

func reload_level() -> void :
	current_level.queue_free()
	current_level = levels[current_nmb_level].instantiate()
	current_level.level_end.connect(finished_level)
	princess.spawn()
	
	current_level.spawn(princess, knight)
	princess.input_disabled=false
	death.hide()
	death.audio_stream_player.stop()
	
	add_child(current_level)
	$AudioStreamPlayer.play()
	

func dead() :
	death.activate()
	current_level.spawn(princess,knight)

signal win

func finished_level(body : Node2D) ->void :
	
	if body == princess && princess.is_following :
		current_nmb_level += 1
		if current_nmb_level == nmb_level :
			win.emit()
		
		else :
			new_level()


func back_to_menu() -> void:
	go_menu.emit()

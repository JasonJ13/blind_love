extends Node2D

@onready var princess : CharacterBody2D = $Princesse
@onready var knight : CharacterBody2D = $Knight

@export var nmb_level : int = 1
var levels : Array[Resource]
var current_nmb_level : int = 0
var current_level : Level = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in range (nmb_level) :
		levels.append(load("res://Scenes/level/Lvl"+str(n+1)+".tscn"))
	
	new_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func new_level() -> void :
	
	if current_level :
		current_level.queue_free()
	
	current_level = levels[current_nmb_level].instantiate()
	current_level.level_end.connect(finished_level)
	
	add_child(current_level)
	
	current_level.spawn(princess, knight)

func finished_level(body : Node2D) ->void :
	
	if body == princess && princess.is_following :
		print("level_end")

extends Control


@onready var mainMenu : Control = $MainMenu

var main_level_preload : Resource = preload("res://Scenes/level/main_level.tscn")
var intro_preload : Resource = preload("res://Scenes/intro.tscn")

@onready var panel_hand : Panel = $hold_hand
@onready var fades : AnimationPlayer = $fondu


var levels : Node2D
var intro : Node2D 

var can_begin : bool = false

# Called when the node enters the scene tree for the first time.


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Space") && can_begin :
		panel_hand.hide()
		can_begin = false
		levels = main_level_preload.instantiate()
		levels.go_menu.connect(back_to_menu)
		levels.win.connect(has_win)
		add_child(levels)
	
	if Input.is_action_just_pressed("Space") && ending_there :
		back_to_menu()
		ending_there = false
		ending.hide()



func intro_Start() -> void:
	intro = intro_preload.instantiate()
	
	intro.intro_finished.connect(show_panel)
	
	add_child(intro)

func show_panel() -> void:
	fades.play("fade_in")


func animation_end(anim_name: StringName) -> void:
	if anim_name == "fade_in" :
		panel_hand.show()
		if intro :
			intro.queue_free()
		fades.play("fade_out")
		can_begin = true
		


@onready var ending = $Ending
var ending_there = false

func back_to_menu() :
	mainMenu.process_mode = Node.PROCESS_MODE_INHERIT
	mainMenu.start_game.connect(intro_Start)
	mainMenu.show()
	
	if levels :
		levels.queue_free()
	
func has_win() -> void :
	levels.queue_free()
	ending.show()
	ending_there = true
	

class_name Textbox extends Control

@onready var margin_container: MarginContainer = $MarginContainer/MarginContainer
@onready var label: RichTextLabel = $MarginContainer/MarginContainer/HBoxContainer/Label

@export var dialogue_path:String

enum State{READY,READING,FINISHED}
var tween:Tween
var current_state=State.READY
var text_queue:Array=[]
var active


func _ready() -> void:
	hide()
	label.hide()
	
	load_dialogue()
	print(text_queue)
	active=true

func load_dialogue():
	var file=FileAccess.open(dialogue_path,FileAccess.READ)
	
	while file.get_position()<file.get_length():
		text_queue.append(file.get_line())
	
	file.close()


func _process(_delta: float) -> void:
	match current_state:
		State.READY:
			if !text_queue.is_empty() and active:
				display_text()
		State.READING:
			if Input.is_action_just_pressed("Space"):
				tween.stop()
				change_state(State.FINISHED)
			elif !tween.is_running():
				change_state(State.FINISHED)
		State.FINISHED:
			if  Input.is_action_just_pressed("Space"):
				change_state(State.READY)
				if text_queue.is_empty():
					active=false
					hide_textbox()
				else:
					display_text()

func change_state(state):
	current_state=state

func add_queue_text(text):
	text_queue.append(text)

func hide_textbox():
	hide()
	label.hide()
	
func show_textbox():
	show()
	label.show()

func display_text():
	var text = text_queue.pop_front()
	label.text=text
	change_state(State.READING)
	tween=create_tween()
	label.visible_characters=0
	tween.tween_property(label,"visible_characters",label.get_total_character_count(),len(text)*0.01)
	show_textbox()

class_name Textbox extends CanvasLayer

@onready var margin_container: MarginContainer = $MarginContainer/MarginContainer
@onready var label: RichTextLabel = $MarginContainer/MarginContainer/HBoxContainer/Label
@onready var knight: AudioStreamPlayer = $knight
@onready var princesse: AudioStreamPlayer = $princesse
@onready var space: AudioStreamPlayer = $space
@onready var princessdialogue: Sprite2D = $Princessdialogue
@onready var chevalierdialogue: Sprite2D = $Chevalierdialogue

@export var dialogue_path:String

enum State{READY,READING,FINISHED}
var tween:Tween
var current_state=State.READY
var text_queue:Array=[]
var active

enum chara{princesse,knight}

var talking=chara.princesse

func _ready() -> void:
	hide()
	label.hide()
	
	load_dialogue()
	

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
			if talking==chara.knight and !knight.is_playing():
				knight.play()
			elif talking==chara.princesse and !princesse.is_playing():
				princesse.play()
			if Input.is_action_just_pressed("Space"):
				space.play()
				tween.stop()
				knight.stop()
				princesse.stop()
				label.visible_characters=label.text.length()
				change_state(State.FINISHED)
			elif !tween.is_running():
				change_state(State.FINISHED)
				knight.stop()
				princesse.stop()
		State.FINISHED:
			if  Input.is_action_just_pressed("Space"):
				space.play()
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
	if label.text.begins_with("Léandre"):
		talking=chara.knight
		princessdialogue.hide()
		chevalierdialogue.show()
	if label.text.begins_with("Daelen"):
		talking=chara.princesse
		princessdialogue.show()
		chevalierdialogue.hide()
	change_state(State.READING)
	tween=create_tween()
	label.visible_characters=0
	tween.tween_property(label,"visible_characters",label.get_total_character_count(),len(text)*0.01)
	show_textbox()

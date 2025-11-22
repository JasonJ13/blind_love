extends CanvasLayer

var active = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Echap") :
		if active:
			hide_menu()
			active=false
		else:
			show_menu()
			active = true
	

func hide_menu():
	hide()

func show_menu():
	show()

func _on_resume_pressed() -> void:
	hide_menu()
	active = false


func _on_mainmenuback_pressed() -> void:
	active=false
	var next_scence=preload("res://Scenes/Interface/main_menu.tscn")
	get_tree().change_scene_to_packed(next_scence)

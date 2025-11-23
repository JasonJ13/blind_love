extends CanvasLayer

@export var princesse:CharacterBody2D
var active = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Echap") :
		if active:
			hide_menu()
			active=false
		else:
			show_menu()
			active = true
	

func hide_menu():
	princesse.input_disabled=false
	hide()

func show_menu():
	princesse.input_disabled=true
	show()

func _on_resume_pressed() -> void:
	hide_menu()
	active = false


func _on_mainmenuback_pressed() -> void:
	var tree = get_tree()
	var cur_scene = tree.get_current_scene()
	var packed_scene: PackedScene = load("res://Scenes/Interface/main_menu.tscn") 
	var new_scene = packed_scene.instantiate()
	tree.get_root().add_child(new_scene)
	tree.set_current_scene(new_scene)
	tree.get_root().remove_child(cur_scene)

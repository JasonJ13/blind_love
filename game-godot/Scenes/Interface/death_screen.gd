extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_pressed() -> void:
	pass # Replace with function body.




func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_backmainmenu_pressed() -> void:
	var tree = get_tree()
	var cur_scene = tree.get_current_scene()
	var packed_scene: PackedScene = load("res://Scenes/Interface/main_menu.tscn") 
	var new_scene = packed_scene.instantiate()
	tree.get_root().add_child(new_scene)
	tree.set_current_scene(new_scene)
	tree.get_root().remove_child(cur_scene)

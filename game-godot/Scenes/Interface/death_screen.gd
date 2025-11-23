extends CanvasLayer


func activate 

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()




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

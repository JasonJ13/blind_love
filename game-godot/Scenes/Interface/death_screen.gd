extends CanvasLayer


@export var princesse:CharacterBody2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var is_active=false

func activate():
	if !is_active:
		stop_all_audio()
		if !audio_stream_player.is_playing():
			audio_stream_player.play()
		princesse.input_disabled=true
		princesse.stop_animation()
		show()
		is_active=true
	

func _on_retry_pressed() -> void:
	is_active=false
	princesse.input_disabled=false
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
	
func stop_all_audio():
	var root = get_tree().current_scene
	_stop_audio_recursive(root)

func _stop_audio_recursive(node):
	if node is AudioStreamPlayer or node is AudioStreamPlayer2D:
		node.stop()
		
	for child in node.get_children():
		_stop_audio_recursive(child)

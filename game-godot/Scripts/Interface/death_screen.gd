extends CanvasLayer


@export var princesse:CharacterBody2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var is_active=false

signal retry
signal go_menu

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
	retry.emit()
	


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_backmainmenu_pressed() -> void:

	go_menu.emit()


	
func stop_all_audio():
	var root = get_tree().current_scene
	_stop_audio_recursive(root)

func _stop_audio_recursive(node):
	if node is AudioStreamPlayer or node is AudioStreamPlayer2D:
		node.stop()
		
	for child in node.get_children():
		_stop_audio_recursive(child)

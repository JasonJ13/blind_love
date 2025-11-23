extends Control

signal start_game


func _on_start_pressed() -> void:
	$StartSound.play()
	$AudioStreamPlayer.stop()
	await get_tree().create_timer(0.5).timeout
	start_game.emit()
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED



func _on_quit_pressed() -> void:
	get_tree().quit()

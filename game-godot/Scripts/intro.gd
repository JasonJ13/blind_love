extends Node2D

@onready var princesse: CharacterBody2D = $Princesse
@onready var knight: CharacterBody2D = $Knight
@onready var dialogue_box: Textbox = $dialogue_box
@onready var audio_stream_player: AudioStreamPlayer = $porte
@onready var musique: AudioStreamPlayer = $musique

var flag1=false
var flag2=false
var flag3=false
var son_porte=false
var next_scene:Resource

func _ready() -> void:
	princesse.input_disabled=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !flag1:
		princesse.velocity=princesse.SPEED *Vector2.LEFT
		princesse.play_animation("left")
		princesse.move_and_slide()
		if princesse.global_position.distance_to(knight.global_position)<160:
			flag1=true
			princesse.stop_animation()
			musique.play() 
	if !flag2 and flag1:
		get_tree().create_timer(1).timeout
		knight.velocity=princesse.SPEED*Vector2.RIGHT
		knight.play_animation("right")
		knight.move_and_slide()
		if princesse.global_position.distance_to(knight.global_position)<100:
			flag2=true
			knight.stop_anim()
			dialogue_box.active=true
	if flag2 and !dialogue_box.active:
		if !son_porte:
			audio_stream_player.play()
			son_porte=true
			flag3=true
	if flag3 and !audio_stream_player.is_playing():
		knight.velocity=princesse.SPEED/2*Vector2.RIGHT
		knight.play_animation("right")
		knight.move_and_slide()
		musique.stop()
		if princesse.global_position.distance_to(knight.global_position)<40:
			change_scene()
		
func change_scene():
	
		var tree = get_tree()
		var cur_scene = tree.get_current_scene()
		var packed_scene: PackedScene = load("res://Scenes/level/Lvl1.tscn") 
		var new_scene = packed_scene.instantiate()
		tree.get_root().add_child(new_scene)
		tree.set_current_scene(new_scene)
		tree.get_root().remove_child(cur_scene)

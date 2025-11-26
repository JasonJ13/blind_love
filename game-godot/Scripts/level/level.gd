extends Node2D
class_name Level

@export var grill : TileMapLayer
var roue_grill : Array[Actionner]
@export var roues : Node2D
@onready var grille_sound : AudioStreamPlayer2D = $GrilleStreamPlayer2D

@export var spawn_point_princesse : Node2D
@export var spawn_point_knight : Node2D

func get_spawn_point_pr() -> Vector2 :
	return spawn_point_princesse.position

func get_spawn_point_kn() -> Vector2 :
	return spawn_point_knight.position

signal level_end

func init_roue() -> void :
	for roue in roues.get_children() :
		roue_grill.append(roue)


func remove_grill() -> void :
	if grill :
		grille_sound.play()
		grill.queue_free()

func is_actioned() -> void :
	
	for roue in roue_grill :
		if !roue.is_actived() :
			print(roue.is_actived())
			return
	
	for roue in roue_grill :
		roue.all_active()
	remove_grill()

func spawn(princess : CharacterBody2D, knight : CharacterBody2D) -> void:
	princess.position = spawn_point_princesse.position
	knight.position = spawn_point_knight.position


func level_finished(body: Node2D) -> void:
	level_end.emit(body)

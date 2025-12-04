extends Node2D
class_name Level

@export var grill : TileMapLayer
var actionners_grill : Array[Actionner]
@export var actionners : Node2D
@onready var grille_sound : AudioStreamPlayer2D = $GrilleStreamPlayer2D

@export var spawn_point_princesse : Node2D
@export var spawn_point_knight : Node2D

func get_spawn_point_pr() -> Vector2 :
	return spawn_point_princesse.position

func get_spawn_point_kn() -> Vector2 :
	return spawn_point_knight.position

signal level_end

func _ready() -> void:
	init_actionner()

func init_actionner() -> void :
	for actionner in actionners.get_children() :
		actionners_grill.append(actionner)


func remove_grill() -> void :
	if grill :
		grille_sound.play()
		grill.queue_free()


func is_actioned_roue() -> void :
	for actionner in actionners_grill :
		if actionner is Roue && !actionner.is_actived() :
			return
	
	for actionner in actionners_grill :
		if actionner is Roue :
			actionner.all_active()
	is_actioned()

func is_actioned() -> void :
	
	for actionner in actionners_grill :

		if !actionner.is_actived() :
			return
	
	for actionner in actionners_grill :
		actionner.as_resolve()
	remove_grill()

func spawn(princess : CharacterBody2D, knight : CharacterBody2D) -> void:
	princess.position = spawn_point_princesse.position
	knight.position = spawn_point_knight.position


func level_finished(body: Node2D) -> void:
	level_end.emit(body)

extends Node2D
class_name Level

@export var grill : TileMapLayer
var roue_grill : Array[Lever]
@export var roues : Node2D

@export var spawn_point_princesse : Node2D
@export var spawn_point_knight : Node2D

signal level_end

func init_roue() -> void :
	for roue in roues.get_children() :
		roue_grill.append(roue)
		roue.is_actived_signal.connect(self.is_actioned)


func remove_grill() -> void :
	if grill :
		grill.queue_free()

func is_actioned() -> void :
	for roue in roue_grill :
		if !roue.is_actived() :
			return
	
	for roue in roue_grill :
		roue.all_active()
	remove_grill()

func spawn(princess : CharacterBody2D, knight : CharacterBody2D) -> void:
	princess.position = spawn_point_princesse.position
	knight.position = spawn_point_knight.position


func level_finished(body: Node2D) -> void:
	level_end.emit(body)

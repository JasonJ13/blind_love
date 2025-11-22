extends Node2D
class_name Level

@export var grill : TileMapLayer
var roue_grill : Array[Roue]
@export var roues : Node2D
@onready var grille_sound : AudioStreamPlayer2D = $GrilleStreamPlayer2D


func init_roue() -> void :
	for roue in roues.get_children() :
		roue_grill.append(roue)
		roue.is_actived_signal.connect(self.is_actioned)


func remove_grill() -> void :
	if grill :
		grille_sound.play()
		grill.queue_free()

func is_actioned() -> void :
	for roue in roue_grill :
		if !roue.is_actived() :
			return
	
	for roue in roue_grill :
		roue.all_active()
	remove_grill()

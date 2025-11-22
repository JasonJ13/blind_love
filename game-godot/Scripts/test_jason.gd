extends Node2D

@onready var princesse : CharacterBody2D = $Princesse
@onready var knight : CharacterBody2D = $Knight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	princesse.set_knight(knight)
	knight.set_princesse(princesse, princesse.get_radius())


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

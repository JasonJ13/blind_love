extends Control

@export var interactable: bool = false
@export var connectable: bool = false
@export var orderable: bool = false
@export var disconnectable: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$VBoxContainer/Interact.visible = interactable
	$VBoxContainer/Connect.visible = connectable
	$VBoxContainer/Disconnect.visible = disconnectable
	$VBoxContainer/Order.visible = orderable
	
	pass

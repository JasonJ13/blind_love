extends TileMapLayer

@export var light : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !light :
		$CanvasModulate.show()

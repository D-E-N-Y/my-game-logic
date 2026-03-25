extends Control
class_name UIPlayerInfo

@export var desktop : UIDesktop

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func CloseWindow():
	desktop._close_window()

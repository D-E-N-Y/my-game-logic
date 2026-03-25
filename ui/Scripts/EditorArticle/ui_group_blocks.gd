extends Node
class_name UIGroupBlocks

@export var editor : UIEditor

@export var blockType : BlockType.E_BlockType
@export var blockButtonPrefab : PackedScene

@export var title : Label 
@export var BlockButtonsContainer : BoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	title.text = str(BlockType.E_BlockType.keys()[blockType])

func AddBlockButton(data : S_Block):
	var blockButton = blockButtonPrefab.instantiate()
	blockButton.Initialize(data, editor)
	
	BlockButtonsContainer.add_child(blockButton)

func RemoveBlockButtons():
	for blockButton in BlockButtonsContainer.get_children():
		blockButton.queue_free()

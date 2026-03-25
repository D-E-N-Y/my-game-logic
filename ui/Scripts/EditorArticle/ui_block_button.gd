extends Button
class_name UIBlockButton

# UI
var editor : UIEditor
@export var blockPrefab : PackedScene
@export var infoDiagram : TextureProgressBar
@export var typeLaber : Label

# data
var data : S_Block
var intoType : InfoType.E_InfoType

func Initialize(data : S_Block, editor : UIEditor):
	self.data = data
	self.editor = editor
	
	var max = -1
	
#	set info diagrama value 
	for inf in data.info:
		if inf.type == InfoType.E_InfoType.Truth:
			infoDiagram.value = float(inf.percentage)
		
		if inf.percentage > max:
			intoType = inf.type
			max = inf.percentage
	
	typeLaber.text = str(InfoType.E_InfoType.keys()[intoType])
		

func _on_button_up():
	var ui_block =  blockPrefab.instantiate()
	ui_block.Initialize(data, intoType, self)
	
	editor.blocksContainer.add_child(ui_block)
	
	var range : float = 250
	var posX : float = -editor.blocksContainer.position.x + editor.blocksContainer.workspace.size.x / 2
	var posY : float = -editor.blocksContainer.position.y + editor.blocksContainer.workspace.size.y / 2
	
	var newPosition : Vector2 = Vector2(randf_range(posX - range, posX + range), 
										randf_range(posY - range, posY + range))
	
	ui_block.position = newPosition
	ui_block.move_and_slide()
	
	editor.AddUIBlock(ui_block)
	
	self.visible = false

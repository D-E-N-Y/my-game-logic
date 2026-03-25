extends CharacterBody2D
class_name UIBlock

var parrentBlock : UIBlock = null
var childBlock : UIBlock = null

@export var typeLabel : Label
var block_button : UIBlockButton
var dragging = false
var offset = Vector2(0, 0)

var order : int

var data : S_Block
var infoType : InfoType.E_InfoType

func Initialize(data : S_Block, infoType : InfoType.E_InfoType, block_button : Button):
	self.data = data
	self.infoType = infoType
	self.block_button = block_button
	
	typeLabel.text = str(BlockType.E_BlockType.keys()[data.blockType])
	order = 0

func GoToParentByOrder():
	if parrentBlock:
		parrentBlock.GoToParentByOrder()
	else:
		order = 0
		
		if childBlock:
			childBlock.GoToChildByOrder(order)

func GoToChildByOrder(order : int):
	order += 1
	self.order = order
	
	if childBlock:
		childBlock.GoToChildByOrder(order)
	else:
		block_button.editor.VerityOrderBlocks()

# dragging
func _dragging():
	while dragging:
		global_position = get_global_mouse_position() - offset
		move_and_slide()
		
		if childBlock:
			UpdateChildPositions()
			
		await get_tree().process_frame  # wait one frame
		# Задержка на следующем кадре
	
	# когда dragging = false, обновляем позиции дочерних элементов
	if parrentBlock:
		parrentBlock.UpdateChildPositions()
	GoToParentByOrder()

# update position child block
func UpdateChildPositions():
	childBlock.position = Vector2(position.x, position.y + 100)
	
	# if child block has own child block
	if childBlock.childBlock:
		childBlock.UpdateChildPositions()

# button down
func StartDrag():
	dragging = true
	offset = get_global_mouse_position() - global_position
	await _dragging()

# button up
func StopDrag():
	dragging = false


# add child block
func AreaBottonEntered(area):
	if area.owner != self and area.owner is UIBlock and !childBlock:
		if area.owner.childBlock != self:
			area.owner.parrentBlock = self
			childBlock = area.owner

# remove child block
func AreaBottonExited(area):
	if area.owner != self and area.owner == childBlock:
		if area.owner:
			area.owner.parrentBlock = null
			childBlock = null
		
func ClearParrentChild():
	if parrentBlock:
		parrentBlock.childBlock = null
		parrentBlock.GoToParentByOrder()
		
	if childBlock:
		childBlock.parrentBlock = null
		childBlock.GoToParentByOrder()

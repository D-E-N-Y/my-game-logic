extends Panel
class_name UIBlocksContainer

@export var workspace : Control

var canManipulation : bool = false
var canMoving : bool = false
var offset : Vector2 = Vector2.ZERO

var centerX : float
var centerY : float

var stepScale : float = 0.01
var minScale : float = 0.25
var maxScale : float = 2

@export var leftBorder : CollisionShape2D
@export var rightBorder : CollisionShape2D
@export var topBorder : CollisionShape2D
@export var bottontBorder : CollisionShape2D

enum SideBorder
{
	Left,
	Right,
	Top,
	Botton
}

func Initialize():
	while(true):
		if workspace.size > Vector2.ZERO:
			break
		await get_tree().process_frame

	size = workspace.size * 4
	
	pivot_offset.x = size.x / 2
	pivot_offset.y = size.y / 2
	
	centerX = (size.x - workspace.size.x) / 2
	centerY = (size.y - workspace.size.y) / 2

	position.x = -centerX
	position.y = -centerY
	
	var shaderMaterial = material as ShaderMaterial
	shaderMaterial.set_shader_parameter("resolution", Vector2(size.x, size.y))
	
	SetupBorder(leftBorder, SideBorder.Left)
	SetupBorder(rightBorder, SideBorder.Right)
	SetupBorder(topBorder, SideBorder.Top)
	SetupBorder(bottontBorder, SideBorder.Botton)

func SetupBorder(border : CollisionShape2D, side : SideBorder):
	var rectangleShape : RectangleShape2D = border.shape as RectangleShape2D
	rectangleShape.size = Vector2(size.x * 3, size.x * 3)
	
	var sidePosition = {
		SideBorder.Left: Vector2(-rectangleShape.size.x / 2, size.y / 2), 
		SideBorder.Right: Vector2(size.x + rectangleShape.size.x / 2, size.y / 2), 
		SideBorder.Top: Vector2(size.x / 2, -rectangleShape.size.y / 2),
		SideBorder.Botton: Vector2(size.x / 2, size.y + rectangleShape.size.y / 2)
		}
	
	border.position = sidePosition[side]

func BlockContainerMouseEnter():
	canManipulation = true

func  BlockContainerMouseExit():
	canManipulation = false
	canMoving = false

func _input(event):
	if event is InputEventMouseButton:
		if canManipulation:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
				scale += Vector2.ONE * stepScale
				scale.x = clamp(scale.x, minScale, maxScale)
				scale.y = clamp(scale.y, minScale, maxScale)
				Move(position)
				
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
				scale -= Vector2.ONE * stepScale
				scale.x = clamp(scale.x, minScale, maxScale)
				scale.y = clamp(scale.y, minScale, maxScale)
				Move(position)
			
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				canMoving = true
				offset = get_global_mouse_position() - self.position
				await Moving()
				
			if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
				canMoving = false

func Moving():
	while canMoving:
		var newPosition : Vector2 = get_global_mouse_position() - offset
		Move(newPosition)
		
		await get_tree().process_frame

func Move(position : Vector2):
	var limitLeft = pivot_offset.x * (scale.x - 1)
	var limitRight = -((centerX + limitLeft) * 2 - limitLeft)
	
	var limitTop = pivot_offset.y * (scale.y - 1)
	var limitBotton = -((centerY + limitTop) * 2 - limitTop)
	
	position.x = clamp(position.x, limitRight, limitLeft)
	position.y = clamp(position.y, limitBotton, limitTop)
	
	self.position = position

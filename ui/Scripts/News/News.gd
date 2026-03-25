extends Resource
class_name News

# news parameters
@export var title : String
@export var preview : Texture2D
@export var content : String

# blocks parameters
@export var blocks : Array[S_Block] = []

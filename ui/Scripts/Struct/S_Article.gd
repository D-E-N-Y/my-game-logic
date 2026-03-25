extends Resource
class_name S_Article

var info : Array[Info] = []

#var info : Dictionary = {}
var boostCorrectOrder: float
var boostFromInfoRatio : float

var header : String
var anotation : String
var keywords : String
var introduction : String
var content : String
var conclusions : String
var source : String

func  _init(info : Array[Info], 
			boostCorrectOrder: float, 
			boostFromInfoRatio : float, 
			header : String, 
			anotation : String,
			keywords : String,
			introduction : String,
			content : String,
			conclusions : String,
			source : String):
	
	self.info = info
	self.boostCorrectOrder = boostCorrectOrder
	self.boostFromInfoRatio = boostFromInfoRatio
	
	self.header = header
	self.anotation = anotation
	self.keywords = keywords
	self.introduction = introduction
	self.content = content
	self.conclusions = conclusions
	self.source = source

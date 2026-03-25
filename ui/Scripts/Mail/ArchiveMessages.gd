extends Node

@export var messages : Array[S_Message] = []

func _ready():
	ArchiveMessages.messages = messages

func GetMessage(triger : int) -> Array[Message]:
	var _m = null
	
	for message in messages:
		if message.triger == triger:
			print("find")
			_m = message.messages
			break
	
	print(_m)		
	
	return _m

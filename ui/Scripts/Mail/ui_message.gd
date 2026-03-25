extends Button
class_name UIMessage

var window : UIMail
var data : Message

@export var TitleLabel : Label
@export var AuthorLabel : Label
@export var MainTextLabel : Label

func Initialize(data : Message, window : UIMail):
	self.data = data
	self.window = window
	
	TitleLabel.text = data.title
	AuthorLabel.text = data.author
	MainTextLabel.text = data.mainText

func ViewInfo():
	window.ViewInfoMessage(self)

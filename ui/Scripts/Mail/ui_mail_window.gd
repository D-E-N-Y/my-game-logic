extends Control
class_name UIMail

signal NewMail

@export var desktop : UIDesktop

@export var messageContainer : BoxContainer
@export var messagePrefab : PackedScene
var selectMessage : UIMessage

@export var TittleLabel : Label
@export var AutorLabel : Label
@export var MainLabel : Label

@export var ThreatBottonPanel : BoxContainer
@export var SuggestionBottonPanel : BoxContainer


func _ready():
	BubbleSystem.mail = self


func AddMessage(message : Message):
	var ui_message = messagePrefab.instantiate()
	ui_message.Initialize(message, self)
	messageContainer.add_child(ui_message)
	NewMail.emit()


func ViewInfoMessage(message : UIMessage):
	selectMessage = message
	
	TittleLabel.text = message.data.title
	AutorLabel.text = message.data.author
	AutorLabel.text = message.data.mainText
	
	if message.data is Suggestion:
		ThreatBottonPanel.visible = false
		
		SuggestionBottonPanel.visible = true
		for button : Button in SuggestionBottonPanel.get_children():
			button.disabled = message.data.isUse
		
	elif message.data is Threat:
		ThreatBottonPanel.visible = true
		SuggestionBottonPanel.visible = false

func ClearInfo():
	selectMessage.focus_mode = Control.FOCUS_NONE
	selectMessage = null
	
	TittleLabel.text = ""
	AutorLabel.text = ""
	AutorLabel.text = ""
	
	ThreatBottonPanel.visible = false
	SuggestionBottonPanel.visible = false

func CloseWindow():
	desktop._close_window()


func Ok():
	var _message : Threat = selectMessage.data
	_message.OK()
	ClearInfo()

func Apply():
	var _message : Suggestion = selectMessage.data
	_message.Apply()
	ClearInfo()

func Cancel():
	var _message : Suggestion = selectMessage.data
	_message.Cancel()
	ClearInfo()

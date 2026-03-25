extends Control
class_name UIDesktop

var active_window : Control
@export var editor_article_window : UIEditor
@export var news_window : UINewsWindow
@export var published_articles_window : UIPublishedArticles
@export var mail_window : UIMail
@export var player_info : UIPlayerInfo
@export var mouse_click: AudioStreamPlayer
@export var mail_sound: AudioStreamPlayer
@export var warning_label: Label

func _ready():
	mail_window.NewMail.connect(_on_new_mail)


func _close_window():
	if(active_window != null):
		active_window.visible = false
		active_window = null

func _open_window(_window : Control):
	if(_window == null):
		print("window is null")
		pass
	
	if(active_window == _window):
		_close_window()
	else:
		_close_window()
		active_window = _window
		active_window.visible = true

func _on_editor_button_pressed():
	_open_window(editor_article_window)
	mouse_click.play()

func _on_news_button_pressed():
	_open_window(news_window)
	mouse_click.play()

func _on_articles_button_pressed():
	_open_window(published_articles_window)
	mouse_click.play()

func OpenMail():
	_open_window(mail_window)
	mouse_click.play()

func OpenPlayerInfo():
	_open_window(player_info)
	mouse_click.play()

func _on_new_mail():
	warning_label.visible = true
	mail_sound.play()
	await mail_sound.finished
	warning_label.visible = false

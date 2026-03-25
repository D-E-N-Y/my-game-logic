extends Control
class_name UINewsWindow

@export var desktop : UIDesktop

@export var newsPrefab : PackedScene
@export var newsContainer : GridContainer

@export var tittleNews : Label
@export var previewNews : TextureRect
@export var contentNews : Label
@export var warningLabel : Label

var selectedNews : UINews

# Called when the node enters the scene tree for the first time.
func _ready():
	await delay(1.0)
	
	for _news in ArchiveNews.GetRandomNews():
		var ui_news = newsPrefab.instantiate()
		ui_news.Initialize(_news, self)
		
		newsContainer.add_child(ui_news)
		ArchiveNews.AddUseNews(ui_news.data)

func delay(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func ViewNews(news : UINews):
	selectedNews = news
	
	tittleNews.text = news.data.title
	previewNews.texture = news.data.preview
	contentNews.text = news.data.content

func CreateArticle():
	if !selectedNews:
		print("no select news")
		WarningTween("No news selected")
		return
	
	if desktop.editor_article_window.IsEdit():
		print("You already creating article")
		WarningTween("You already creating article")
		return
	
	desktop._on_editor_button_pressed()
	desktop.editor_article_window.SetupBlocks(selectedNews.data.blocks)
	ClearInfoNews()

func ClearInfoNews():
	ArchiveNews.AddUseNews(selectedNews.data)
	
	selectedNews.queue_free()
	selectedNews = null
	
	tittleNews.text = ""
	previewNews.texture = null
	contentNews.text = ""
	
	


func CloseWindow():
	desktop._close_window()


var tween : Tween
func WarningTween(text):
	warningLabel.modulate.a = 1
	warningLabel.text = text
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(warningLabel, "modulate:a", 0, 2)

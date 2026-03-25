extends Node

@export var news : Array[News] = []
var usedNews : Array[News] = []

func GetRandomNews() -> Array[News]:
	return news

func AddUseNews(news : News):
	usedNews.append(news)

func _ready():
	ArchiveNews.news = news

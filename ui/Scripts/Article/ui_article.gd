extends Button
class_name UIArticle

# UI
var window : UIPublishedArticles
@export var ui_article : Button

# data
var data : S_Article
var auditorium : Dictionary

func Initialize(data : S_Article, auditorium : Dictionary, window : UIPublishedArticles):
	self.data = data
	self.auditorium = auditorium
	self.window = window
		
	ui_article.text = data.header

# pressed button
func ViewInfo():
	window.ViewInfoArticle(data, auditorium)

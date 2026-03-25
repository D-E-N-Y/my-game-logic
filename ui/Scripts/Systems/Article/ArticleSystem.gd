extends Node

var articles : Array[S_Article] = []

func AddArticle(article : S_Article):
	articles.append(article)

func RemoveArticle(article : S_Article):
	articles.erase(article)

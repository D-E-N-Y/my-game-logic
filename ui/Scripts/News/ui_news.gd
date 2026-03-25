extends Button
class_name UINews

# UI
@export var title : Label
@export var preview : TextureRect
var window : UINewsWindow

# data
var data : News

func Initialize(data : News, window : UINewsWindow):
	self.data = data
	self.window = window
	
	title.text = data.title
	preview.texture = data.preview

# press button
func SelectNews():
	window.ViewNews(self)

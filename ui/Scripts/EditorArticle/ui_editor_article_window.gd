extends Control
class_name UIEditor

@export var desktop : UIDesktop
@export var blocksContainer : Control

# UI blocks
@export var groupBlocksContainer : VBoxContainer
var _UIGroupBlocks : Array[UIGroupBlocks] = []
var _UIBlocks : Array[UIBlock] = []

# UI info diagram
@export var infoDiagram : TextureProgressBar
@export var truthPrecentageLabel : Label
@export var propagandaPrecentageLabel : Label
var truthPrecentage : float
var propagandaPrecentage : float

# UI oreder correctly diagram
@export var orderCorrectlyDiagram : ProgressBar
@export var correctOrderPercentageLabel : Label

# UI boost
@export var boostFromInfoRatioPercentageLabel : Label
@export var boostFromOrderPercentageLabel : Label
var boostFromInfoRatioPercentage : float
var boostFromOrderPercentage : float

# UI article
@export var headerLabel : Label
@export var anotationLabel : Label
@export var keywordsLabel : Label
@export var introductionLabel : Label
@export var contentLabel : Label
@export var conclusionsLabel : Label
@export var sourceLabel : Label
@export var warningLabel : Label

# data
var blocks : Array[S_Block] = []


func SetupBlocks(blocks : Array[S_Block]):
	self.blocks = blocks
	
	for _UIGroup in groupBlocksContainer.get_children():
		_UIGroupBlocks.append(_UIGroup)
		for block in blocks:
			if _UIGroup.blockType == block.blockType:
				_UIGroup.AddBlockButton(block)

func AddUIBlock(_UIBlock : UIBlock):
	
	for block in _UIBlocks:
		if block.data.blockType == _UIBlock.data.blockType:
			RemoveUIBlock(block)
			break
	
	_UIBlocks.append(_UIBlock)
	
	CalculateBoostFromInfoRatio()
	CalculateInfo()
	
	match _UIBlock.data.blockType:
		BlockType.E_BlockType.Header:
			headerLabel.text = _UIBlock.data.content
		BlockType.E_BlockType.Anotation:
			anotationLabel.text = _UIBlock.data.content
		BlockType.E_BlockType.Keywords:
			keywordsLabel.text = _UIBlock.data.content
		BlockType.E_BlockType.Introduction:
			introductionLabel.text = _UIBlock.data.content
		BlockType.E_BlockType.Content:
			contentLabel.text = _UIBlock.data.content
		BlockType.E_BlockType.Conclusions:
			conclusionsLabel.text = _UIBlock.data.content
		BlockType.E_BlockType.Source:
			sourceLabel.text = _UIBlock.data.content
	
func CalculateInfo():
	truthPrecentage  = 0
	propagandaPrecentage = 0
	
	for _UIblock in _UIBlocks:
		for info in _UIblock.data.info:
			match info.type:
				InfoType.E_InfoType.Propaganda:
					propagandaPrecentage += info.percentage
				InfoType.E_InfoType.Truth:
					truthPrecentage += info.percentage
	
	truthPrecentage /= _UIBlocks.size()
	propagandaPrecentage /= _UIBlocks.size()
	
	infoDiagram.tint_under = Color("cc4441", 1)
	infoDiagram.value = truthPrecentage
	
	truthPrecentageLabel.text = "%.2f" % truthPrecentage + "%"
	propagandaPrecentageLabel.text = "%.2f" % propagandaPrecentage + "%"

func RemoveUIBlock(_UIBlock : UIBlock):
	_UIBlock.ClearParrentChild()
	_UIBlocks.erase(_UIBlock)
	_UIBlock.block_button.visible = true
	_UIBlock.queue_free()


func VerityOrderBlocks():
	var current : float = 0
	
	for _UIBlock in _UIBlocks:
		if _UIBlock.data.blockType == _UIBlock.order:
			current += 1
	
	boostFromOrderPercentage = (current / _UIGroupBlocks.size()) * 100
	orderCorrectlyDiagram.value = boostFromOrderPercentage
	correctOrderPercentageLabel.text = "%.2f" % boostFromOrderPercentage + "%"
	boostFromOrderPercentageLabel.text = "+" + "%.2f" % boostFromOrderPercentage + "%"

func CalculateBoostFromInfoRatio():
	var propaganda : float = 0 
	var truth : float = 0
	
	for _UIBlock in _UIBlocks:
		match _UIBlock.infoType:
			InfoType.E_InfoType.Propaganda:
				propaganda += 1
			InfoType.E_InfoType.Truth:
				truth += 1
	
	boostFromInfoRatioPercentage = abs(propaganda - truth) / _UIBlocks.size() * 100
	boostFromInfoRatioPercentageLabel.text = "+" + "%.2f" % boostFromInfoRatioPercentage + "%"

func IsEdit() -> bool:
	return !blocks.is_empty()

func IsBuilt() -> bool:
	if _UIBlocks.is_empty() or _UIBlocks.size() != _UIGroupBlocks.size():
		print("not enougth blocks")
		WarningTween("Not enough blocks")
		return false
	
	for i in range(_UIBlocks.size() - 1):
		for j in range(i + 1, _UIBlocks.size()):
			if _UIBlocks[i].order == _UIBlocks[j].order:
				print("blocks not built")
				WarningTween("The article is not full builded")
				return false
	
	return true

func ClearArticle():
	for _UIBlock in _UIBlocks:
		_UIBlock.block_button.visible = true
		_UIBlock.queue_free()
	
	_UIBlocks.clear()
	
	headerLabel.text = ""
	anotationLabel.text = ""
	keywordsLabel.text = ""
	introductionLabel.text = ""
	contentLabel.text = ""
	conclusionsLabel.text = ""
	sourceLabel.text = ""
	
	infoDiagram.value = 0
	infoDiagram.tint_under = Color("0d0a22", 1)
	
	orderCorrectlyDiagram.value = 0
	correctOrderPercentageLabel.text = "0%"
	
	truthPrecentageLabel.text = "0%"
	propagandaPrecentageLabel.text = "0%"
	
	boostFromInfoRatioPercentageLabel.text = "+0%"
	boostFromOrderPercentageLabel.text = "+0%"

func PublishArticle():
	if !IsBuilt():
		return
	
	var info : Array[Info] = []
	
	var infoPropaganda : Info = Info.new()
	infoPropaganda.type = InfoType.E_InfoType.Propaganda
	infoPropaganda.percentage = propagandaPrecentage
	
	var infoTruth : Info = Info.new()
	infoTruth.type = InfoType.E_InfoType.Truth
	infoTruth.percentage = truthPrecentage
	
	info.append(infoPropaganda)
	info.append(infoTruth)
	
	var article : S_Article = S_Article.new(info, 
											boostFromOrderPercentage,
											boostFromInfoRatioPercentage,
											headerLabel.text,
											anotationLabel.text,
											keywordsLabel.text,
											introductionLabel.text,
											contentLabel.text,
											conclusionsLabel.text,
											sourceLabel.text)
	
	desktop.published_articles_window.AddArticle(article)
	desktop._on_articles_button_pressed()
	
	ClearEdit()

func ClearEdit():
	ClearArticle()
	
	for _UIGroup in _UIGroupBlocks:
		_UIGroup.RemoveBlockButtons()
	
	blocks.clear()
	_UIGroupBlocks.clear()


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

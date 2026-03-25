extends Control
class_name UIPublishedArticles

@export var desktop : UIDesktop

# UI
@export var articlesContainer : VBoxContainer
@export var UIArticlePrefab : PackedScene
var _UIArticles : Array[S_Article] = []

@export var AuditoriumDiagram : TextureProgressBar
@export var OppositionistsPercentagesLabel : Label
@export var ProgovernmentalsPercentagesLabel : Label

@export var InfoRatioDiagram : TextureProgressBar
@export var PropagandaPercentagesLabel : Label
@export var TruthPercentagesLabel : Label

@export var OrderCorrectlyDiagram : ProgressBar
@export var CorrectOrderPercentageLabel : Label

@export var BoostFromInfoRatioPercentageLabel : Label
@export var BoostFromOrderPercentageLabel : Label

@export var TitleLabel : Label
@export var AnotationLabel : Label
@export var KeywordsLabel : Label
@export var IntroductionLabel : Label
@export var ContentLabel : Label
@export var ConclusionLabel : Label
@export var SourceLabel : Label

func AddArticle(data : S_Article):
	ArticleSystem.AddArticle(data)
	var auditorium = AuditoriumSystem.CalculateAuditorium(data)
	
	var _UIArticle = UIArticlePrefab.instantiate()
	_UIArticle.Initialize(data, auditorium, self)
	
	_UIArticles.append(_UIArticle)
	articlesContainer.add_child(_UIArticle)

func ViewInfoArticle(data : S_Article, auditorium : Dictionary):
	AuditoriumDiagram.value = float(auditorium[AuditoriumType.E_AuditoriumType.oppositionist]) / (auditorium[AuditoriumType.E_AuditoriumType.progovernmental] + auditorium[AuditoriumType.E_AuditoriumType.oppositionist]) * 100
	AuditoriumDiagram.tint_under = Color("cc4441", 1)
	OppositionistsPercentagesLabel.text = "+" + str(auditorium[AuditoriumType.E_AuditoriumType.oppositionist])
	ProgovernmentalsPercentagesLabel.text = "+" + str(auditorium[AuditoriumType.E_AuditoriumType.progovernmental])
	
	InfoRatioDiagram.value = data.info[1].percentage
	InfoRatioDiagram.tint_under = Color("cc4441", 1)
	PropagandaPercentagesLabel.text = "%.2f" % data.info[0].percentage + "%"
	TruthPercentagesLabel.text = "%.2f" % data.info[1].percentage + "%"

	OrderCorrectlyDiagram.value = data.boostCorrectOrder
	CorrectOrderPercentageLabel.text = "%.2f" % data.boostCorrectOrder + "%"

	BoostFromInfoRatioPercentageLabel.text = "+" + "%.2f" % data.boostFromInfoRatio + "%"
	BoostFromOrderPercentageLabel.text = "+" + "%.2f" % data.boostCorrectOrder + "%"

	TitleLabel.text = data.header
	AnotationLabel.text = data.anotation
	KeywordsLabel.text = "Keywords: "  + data.keywords
	IntroductionLabel.text = data.introduction
	ContentLabel.text = data.content
	ConclusionLabel.text = data.conclusions
	SourceLabel.text = data.source


func CloseWindow():
	desktop._close_window()

extends Node

var boostProgovernmental : float = 0
var boostOppositionist : float = 0

var auditorium : Dictionary = { 
	AuditoriumType.E_AuditoriumType.progovernmental : 0,
	AuditoriumType.E_AuditoriumType.oppositionist : 0
	}

func CalculateAuditorium(article : S_Article) -> Dictionary:
	var progovernmental = int(article.info[0].percentage * (article.boostCorrectOrder + article.boostFromInfoRatio + boostProgovernmental))
	var oppositionist = int(article.info[1].percentage * (article.boostCorrectOrder + article.boostFromInfoRatio + boostOppositionist))
	
	AddAuditorium(AuditoriumType.E_AuditoriumType.progovernmental, progovernmental)
	AddAuditorium(AuditoriumType.E_AuditoriumType.oppositionist, oppositionist)
	
	BubbleSystem.CheckPlayer(GetAuditorium())
	
	var _auditorium = {
		AuditoriumType.E_AuditoriumType.progovernmental : progovernmental, 
		AuditoriumType.E_AuditoriumType.oppositionist : oppositionist
		}
	return _auditorium

func GetAuditorium() -> Dictionary:
	return auditorium

func AddAuditorium(key : AuditoriumType.E_AuditoriumType, amount : int):
	auditorium[key] = auditorium[key] + amount

func RemoveAuditorium(key : AuditoriumType.E_AuditoriumType, amount : int):
	auditorium[key] = max(auditorium[key] - amount, 0)

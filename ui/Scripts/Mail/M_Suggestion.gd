extends Message
class_name Suggestion

@export var price : int
@export var auditoriumType : AuditoriumType.E_AuditoriumType
@export var factorAuditorium : int

var isUse : bool = false

func Apply():
	isUse = true
	
	match auditoriumType:
		AuditoriumType.E_AuditoriumType.progovernmental:
			AuditoriumSystem.boostProgovernmental = factorAuditorium
		
		AuditoriumType.E_AuditoriumType.oppositionist:
			AuditoriumSystem.boostOppositionist = factorAuditorium
	
func Cancel():
	isUse = true

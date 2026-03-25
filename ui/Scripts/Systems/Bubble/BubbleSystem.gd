extends Node

var firsMessage : bool = false
var secondMessage : bool = false
var thirdMessage : bool = false
var fourthMessage : bool = false

var mail : UIMail

func CheckPlayer(auditorium : Dictionary):
	if(!firsMessage):
		if(auditorium[AuditoriumType.E_AuditoriumType.oppositionist] >= 25000) :
			SendMessage(AuditoriumType.E_AuditoriumType.oppositionist, 25000)
			firsMessage = true
		elif(auditorium[AuditoriumType.E_AuditoriumType.progovernmental] >= 25000):
			SendMessage(AuditoriumType.E_AuditoriumType.progovernmental, 25000)
			firsMessage = true
			
	elif(!secondMessage):
		if(auditorium[AuditoriumType.E_AuditoriumType.oppositionist] >= 50000) :
			SendMessage(AuditoriumType.E_AuditoriumType.oppositionist, 50000)
			secondMessage = true
		elif(auditorium[AuditoriumType.E_AuditoriumType.progovernmental] >= 50000):
			SendMessage(AuditoriumType.E_AuditoriumType.progovernmental, 50000)
			secondMessage = true
			
	elif(!thirdMessage):
		if(auditorium[AuditoriumType.E_AuditoriumType.oppositionist] >= 75000) :
			SendMessage(AuditoriumType.E_AuditoriumType.oppositionist, 75000)
			thirdMessage = true
		elif(auditorium[AuditoriumType.E_AuditoriumType.progovernmental] >= 75000):
			SendMessage(AuditoriumType.E_AuditoriumType.progovernmental, 75000)
			thirdMessage = true
			
	elif(!fourthMessage):
		if(auditorium[AuditoriumType.E_AuditoriumType.oppositionist] >= 100000) :
			SendMessage(AuditoriumType.E_AuditoriumType.oppositionist, 100000)
			fourthMessage = true
		elif(auditorium[AuditoriumType.E_AuditoriumType.progovernmental] >= 100000):
			SendMessage(AuditoriumType.E_AuditoriumType.progovernmental, 100000)
			fourthMessage = true

func SendMessage(auditorium : AuditoriumType.E_AuditoriumType, triger : int):
	match auditorium:
		AuditoriumType.E_AuditoriumType.oppositionist:
			var messages : Array[Message] = ArchiveMessages.GetMessage(triger)
			
			for message in messages:
				mail.AddMessage(message)
			
		AuditoriumType.E_AuditoriumType.progovernmental:
			var messages : Array[Message] = ArchiveMessages.GetMessage(triger)
			
			for message in messages:
				if message as Suggestion:
					mail.AddMessage(message)
					break

extends RichTextLabel

onready var SM = get_node("/root/ScoreManager")

func _ready():
	text = "Shots \n" + str(SM.score1) + " " + str(SM.score2) + " " + str(SM.score3) + " " + str(SM.score4)

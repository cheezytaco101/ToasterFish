extends Spatial




func _on_Area_body_entered(body):
	if body.name == "Fish":
		get_node("/root/GameContainer").progress()
		print("Win")

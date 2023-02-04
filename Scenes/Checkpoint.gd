extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var material = $MeshInstance.get_surface_material(0)
	material.albedo_color = Color(1, 0, 0)
	$MeshInstance.set_surface_material(0, material)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	var material = $MeshInstance.get_surface_material(0)
	material.albedo_color = Color(0, 1, 0)
	$MeshInstance.set_surface_material(0, material)

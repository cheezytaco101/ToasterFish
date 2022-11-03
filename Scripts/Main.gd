extends Spatial

#get nodes
onready var player = get_node("Toaster/Fish")
onready var playerTimer = get_node("Toaster/Fish/FlopTimer")
onready var toaster = get_node("Toaster")
onready var camera = get_node("Camera")
onready var powerBar = get_node("PowerBar")

export var spawnOffset = Vector3(0,2,0) #offset for respawning the object
export var fishOffset = Vector3(0,4,-0.7) #offset for the fish so that it appears somewhat outside the toaster
export var fishCameraOffset = Vector3(-6,15,5) #the offset when the camera targets the fish
export var toasterCameraOffset = Vector3(-6,35,19) #the offset when the camera targets the toaster

export var cameraRotation = Vector3(-60,-60,0) #fixed camera rotation

export var toasterCameraSize = 40 #toaster camera size (zoom out)
export var fishCameraSize = 30 #fish camera (zoom in)

export var barSpeed = 2 #how fast thepower bar moves
export var powerValue = 0; #the power
export var powerDirection = 1 #tell power bor to go left or right

export var useCamera = true #camera calculations

onready var PlayerInitTransform = player.transform

func _ready():
	toaster.global_transform.origin = Vector3.ZERO + spawnOffset 
	powerBar.value = powerValue
	

	##REPLACE
	#if useCamera == true:
		#sets the camera location based on the toaster
		#camera.global_transform.origin = toaster.global_transform.origin + toasterCameraOffset
		#camera.rotation_degrees = cameraRotation
		#camera.size = toasterCameraSize
		
	
		

func _process(delta):
	
	camera.fish_position = player.global_transform.origin
	endCheck()
	
	if player.hasBeenShot == true:
		if useCamera == true :
			#change camera focus to the fish
			#camera.size = fishCameraSize
			#camera.global_transform.origin = player.global_transform.origin + toasterCameraOffset
			pass
		
		
	#button controls
	else:
		if Input.is_action_just_released("ui_right"):
			toaster.rotation_degrees.y -= 15
		if Input.is_action_just_released("ui_left"):
			toaster.rotation_degrees.y += 15
			
	if player.hasBeenShot == false:
		if Input.is_action_pressed("Jump"):
			powerValue += barSpeed * powerDirection
			barCheck()
		if Input.is_action_just_released("Jump"):
			player.shootFish(powerValue)
			player.sleeping = false
	#power bar based on the power value
	powerBar.value = powerValue

#check whether the game has end or not. Currently I am just mapping it to the "A" key
func endCheck():
	if true:
		if Input.is_action_just_pressed("move_Left"): #press A to respawn
			nextTurn()
			print("p")
			print(camera.global_transform.origin.x, "; ", camera.global_transform.origin.y, "; ", camera.global_transform.origin.z)
			player.sleeping = true
			player.flopCount = 0
			
#power bar check
func barCheck():
	if powerValue >= 100:
		powerDirection = -1
	if powerValue <= 0:
		powerDirection = 1

func nextTurn():
	#take a new position based on the current fish position
	player.recordNewPosition()
	#set toaster position to fish position
	toaster.global_transform.origin = Vector3(player.global_transform.origin.x, spawnOffset.y, player.global_transform.origin.z)
	#bring the fish to the taoster
	player.transform = PlayerInitTransform
	#player.rotation = Vector3.ZERO
	player.hasBeenShot = false
	playerTimer.resetTimer()
	#reset power
	powerValue = 0
	#if useCamera == true :
		#camera.global_transform.origin = toaster.global_transform.origin + toasterCameraOffset
		#camera.size = toasterCameraSize

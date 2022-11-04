extends Spatial

#get nodes
onready var player = get_node("Toaster/Fish")
onready var playerTimer = get_node("Toaster/Fish/FlopTimer")
onready var toaster = get_node("Toaster")
onready var camera = get_node("Pivot/Camera")
onready var pivot = get_node("Pivot")
onready var powerBar = get_node("Toaster/PowerBar")
onready var toasterInstance = preload("Toaster.tscn")

export var spawnOffset = Vector3(0,2.5,0) #offset for respawning the object
export var fishOffset = Vector3(0,4,-0.7) #offset for the fish so that it appears somewhat outside the toaster
export var fishCameraOffset = Vector3(-6,15,5) #the offset when the camera targets the fish
export var toasterCameraOffset = Vector3(-6,35,19) #the offset when the camera targets the toaster

export var cameraRotation = Vector3(-60,-60,0) #fixed camera rotation

export var toasterCameraSize = 40 #toaster camera size (zoom out)
export var fishCameraSize = 30 #fish camera (zoom in)

export var barSpeed = 3 #how fast thepower bar moves
export var powerValue = 0; #the power
export var powerDirection = 1 #tell power bor to go left or right

export var useCamera = true #camera calculations

onready var PlayerInitTransform = player.transform

var desired_rotation = 2

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
	
	killbox()
	pivot.fish_position = player.global_transform.origin
	endCheck()
	
	if player.hasBeenShot == true:
		if Input.is_action_just_released("ui_right"):
			desired_rotation -= 0.3
		if Input.is_action_just_released("ui_left"):
			desired_rotation += 0.3
		
		pivot.rotation.y = lerp_angle(pivot.rotation.y, desired_rotation, 0.1)
	else:
		if Input.is_action_just_released("ui_right"):
			desired_rotation -= 0.2
		if Input.is_action_just_released("ui_left"):
			desired_rotation += 0.2
		
		toaster.rotation.y = lerp_angle(toaster.rotation.y, desired_rotation, 0.1)
		pivot.rotation.y = lerp_angle(pivot.rotation.y, toaster.rotation.y, 0.05)
		
			
	if player.hasBeenShot == false:
		if Input.is_action_pressed("Jump"):
			powerValue += barSpeed * powerDirection
			barCheck()
		if Input.is_action_just_released("Jump"):
			player.shootFish(powerValue)
			toaster.shoot_particle()
			player.sleeping = false
	else:
		if Input.is_action_just_pressed("Jump"):
				player.flop()
			
	#power bar based on the power value
	powerBar.value = powerValue

#check whether the game has end or not. Currently I am just mapping it to the "A" key
func endCheck():
	#print(player.linear_velocity.length())
	if player.linear_velocity.length() < 0.5:
		if player.hasBeenShot: #press A to respawn
			nextTurn()
			print("p")
			print(camera.global_transform.origin.x, "; ", camera.global_transform.origin.y, "; ", camera.global_transform.origin.z)
			player.sleeping = true
			player.flopCount = 0
			
#power bar check
func barCheck():
	if powerValue >= 100:
		powerValue = 10
	if powerValue <= 0:
		powerDirection = 1

func nextTurn():
	#take a new position based on the current fish position
	player.recordNewPosition()
	#set toaster position to fish position
	toaster.global_transform.origin = Vector3(player.global_transform.origin.x, player.global_transform.origin.y + spawnOffset.y, player.global_transform.origin.z)
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
	toaster.spawn_particle()
	
func killbox():
	if player.global_transform.origin.y < -100: 
		respawn()
		
func respawn():
	toaster.global_transform.origin = Vector3.ZERO + spawnOffset 
	powerBar.value = powerValue
	player.transform = PlayerInitTransform
	player.hasBeenShot = false
	powerValue = 0
	player.sleeping = true

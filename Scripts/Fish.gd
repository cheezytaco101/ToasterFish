#some of the stuff are just place holders just in case I needed it
extends RigidBody

export var xLaunchPower = 30
export var yLaunchPower = 20

export var maxFlops = 2 #currently not used
export var flopCount = 0

export var velocity = Vector3.ZERO
export var flopVelocity = Vector3.ZERO

export var previousLocation = Vector3.ZERO
export var newLocation = Vector3.ZERO

export var hasBeenShot = false #when it shoots, it becomes true until it is reseted, then it becomes false
onready var timer = get_node("FlopTimer")

func _ready():
	sleeping = true
	contact_monitor = true #currently not used. Was for body_entered (just leaving it here just in case needed)
	contacts_reported = 3

#func flopAround():
	#if(flopCount < maxFlops):
		#flopVelocity.y = rand_range(12,17)
		#apply_impulse(Vector3.ZERO, flopVelocity)
		#flopCount += 1

#func _on_FlopTimer_timeout():
	#if(hasBeenShot == true):
	#	flopAround()
	#	timer.resetTimer()
	
func shootFish(var power):
	sleeping = false
	apply_impulse(Vector3.ZERO, get_parent().global_transform.basis.y * 100 * power * 0.01) #x impulse
	#apply_impulse(Vector3.ZERO, global_transform.basis.y * yLaunchPower * power * 0.01)                                               #y impulse
	hasBeenShot = true
	
func flop():
	var p = 0.5
	apply_impulse(self.transform.origin, (global_transform.basis.x * rand_range(-1,1) + global_transform.basis.y + global_transform.basis.z * rand_range(-1,1)) * p)
	
#for when the players die, it records the current position
func recordPreviousPosition():
	previousLocation = global_transform.origin

#record new position 
func recordNewPosition():
	newLocation = global_transform.origin
	

extends RigidBody

var lifetime: float = 100

export var vel = Vector3()

func _ready():
	linear_velocity = vel;
	yield(get_tree().create_timer(lifetime),"timeout")
	queue_free()

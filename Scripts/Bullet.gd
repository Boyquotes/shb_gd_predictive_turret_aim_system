# script ini untuk mengendalikan peluru.

# extend dari rigid body.
extends RigidBody

# batas usia peluru.
var lifetime: float = 100

# variabel untuk menyimpan kecepatan.
export var vel = Vector3()

# saat komponen ready
func _ready():
	# memulai peluncuran.
	linear_velocity = vel;
	
	# menunggu selama lifetime sampai pada akhirnya dihapus.
	yield(get_tree().create_timer(lifetime),"timeout")
	queue_free()

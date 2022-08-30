extends Spatial

export var ray_length = 1000
export var landing_time = 3.0

onready var turret_horizontal = get_node("Base/Body")
onready var turret_vertical = get_node("Base/Body/Muzzle")
onready var spawn = get_node("Base/Body/Muzzle/Spawn")
onready var cam = get_node("/root/World/Camera")
onready var bullet = preload("res://Prefabs/Bullet.tscn")

var target_pos = Vector3()
var vel = Vector3()

func _input(event):
	if event is InputEventMouseMotion:
		var result = cam_to_world(event.position)
		if result.size() > 0 and result["position"] != null:
			target_pos = result["position"]
			
	if event.is_action_pressed("shoot"):
		var bullet_instance = bullet.instance()
		bullet_instance.vel = vel
		bullet_instance.global_transform = spawn.global_transform
		get_tree().get_root().add_child(bullet_instance)
	pass

func _process(delta):
	aim(target_pos)
	pass
	
func _physics_process(delta):
	pass
	
func aim(tgt_pos):
	var v0 = (tgt_pos - global_transform.origin - (0.5 * Vector3(0, -9.8, 0) * landing_time * landing_time))/landing_time
	turret_vertical.look_at(v0, Vector3.UP)
	turret_horizontal.rotate_y(turret_vertical.transform.basis.get_euler().y)
	vel = v0
	pass
	
func cam_to_world(pos):
	return get_world().direct_space_state.intersect_ray(cam.project_ray_origin(pos), cam.project_ray_origin(pos) + cam.project_ray_normal(pos) * ray_length)

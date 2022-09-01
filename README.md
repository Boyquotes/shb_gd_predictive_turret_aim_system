# GDPRDTRRTM - Predictive Turret Aim System dengan Godot Engine

## Software Apakah Ini?

GDPRDTRRTM adalah script Godot Engine yang menunjukkan cara membuat predictive Turret Aim System dengan Godot Engine.

## Cara Mencoba Kode Ini

Untuk mencoba project ini, download folder ini, kemudian buka di Godot Engine 3.4.

Selanjutnya jalankan.

## Pendahuluan

Kali ini kita akan belajar membuat predictive turret aim system di Godot Engine.

Predictive turret aim system adalah sebuah sistem pembidik yang mana peluru atau projectile yang dilontarkan direncanakan untuk jatuh di titik target.

Konsekuensinya, kecepatan awal projectile dan rotasi turret adalah output, sementara posisi akhir dan landing time adalah input.

Dengan sistem ini, turret diarahkan sedemikian rupa sehingga jika bullet ditembakkan dari muzzle turret, maka posisi jatuhnya mendekati titik yang ditunjukkan kursor di ruang 3D.

Kemudian, dicari nilai kecepatan awalnya (v0) berdasarkan input yang diberikan (yang diketahui).

## Penjelasan

```
# file: Bullet.gd

# extend dari rigid body
extends RigidBody

# batas usia peluru
var lifetime: float = 100

# variabel untuk menyimpan kecepatan
export var vel = Vector3()

# saat komponen ready
func _ready():
    # memulai peluncuran
    linear_velocity = vel;

    # menunggu selama lifetime sampai pada akhirnya dihapus
    yield(get_tree().create_timer(lifetime),"timeout")
    queue_free()
```

```
# file: Turret.gd

# extend dari Spatial
extends Spatial

# panjang ray untuk "picking"
export var ray_length = 1000

# waktu mendarat yang diharapkan dalam detik
export var landing_time = 3.0

# begin: assign nodes ke variables
onready var turret_horizontal = get_node("Base/Body")
onready var turret_vertical = get_node("Base/Body/Muzzle")
onready var spawn = get_node("Base/Body/Muzzle/Spawn")
onready var cam = get_node("/root/World/Camera")
# end: assign nodes ke variables

# muat peluru
onready var bullet = preload("res://Prefabs/Bullet.tscn")

# dan lain - lain
var target_pos = Vector3()
var vel = Vector3()

# ketika ada event input
func _input(event):
    # jika event adalah gerakan mouse
    if event is InputEventMouseMotion:
        # konversi koordinat layar ke koordinat world
        var result = cam_to_world(event.position)
        if result.size() > 0 and result["position"] != null:
            target_pos = result["position"]

    # jika event adalah action "shoot" seperti yang disetting di project setting
    if event.is_action_pressed("shoot"):
        # luncurkan peluru
        var bullet_instance = bullet.instance()
        bullet_instance.vel = vel # ambil dari rumus di bawah
        bullet_instance.global_transform = spawn.global_transform
        get_tree().get_root().add_child(bullet_instance)
    pass

# tiap frame. delta adalah selisih waktu
func _process(delta):
    aim(target_pos)
    pass

# abaikan
func _physics_process(delta):
    pass

# bidik
func aim(tgt_pos):
    # rumus fisika SMA
    var v0 = (tgt_pos - global_transform.origin - (0.5 * Vector3(0, -9.8, 0) * landing_time * landing_time))/landing_time

    # arahkan muzzle ke nilai v0
    turret_vertical.look_at(v0, Vector3.UP)

    # parent node nya juga harus diposisikan agar sesuai dengan child nya
    turret_horizontal.rotate_y(turret_vertical.transform.basis.get_euler().y)

    # ini nanti akan digunakan di input event di atas
    vel = v0
    pass

# konversi koordinat layar ke world
func cam_to_world(pos):
    return get_world().direct_space_state.intersect_ray(cam.project_ray_origin(pos), cam.project_ray_origin(pos) + cam.project_ray_normal(pos) * ray_length)
```

# 

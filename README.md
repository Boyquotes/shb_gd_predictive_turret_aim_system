# GDPRDTRRTM - Predictive Turret Aim System dengan Godot Engine

## Software Apakah Ini?

GDPRDTRRTM adalah script Godot Engine yang menunjukkan cara membuat predictive Turret Aim System dengan Godot Engine.

## Screenshot

![ScreenShot](.readme-assets/GDPRDTRRTM-1.png?raw=true)

## Cara Mencoba Kode Ini

Untuk mencoba kode ini, Anda memerlukan Godot Engine v3.5.

Download dan install software tersebut.

Kemudian buka project ini dan jalankan.

## Pendahuluan

Kali ini saya akan memberi contoh cara membuat predictive turret aim system di Godot Engine.

## Cara Kerja

Predictive turret aim system adalah sebuah sistem pembidik yang mana peluru atau projectile yang dilontarkan direncanakan untuk jatuh di titik target.

Konsekuensinya, kecepatan awal projectile dan rotasi turret adalah output, sementara posisi akhir dan landing time adalah input.

Dengan sistem ini, turret diarahkan sedemikian rupa sehingga jika bullet ditembakkan dari muzzle turret, maka posisi jatuhnya mendekati titik yang ditunjukkan kursor di ruang 3D.

Kemudian, dicari nilai kecepatan awalnya (v0) berdasarkan input yang diberikan (yang diketahui).

## Struktur Project

Untuk melihat struktur project game ini, silakan buka project ini di Godot Engine.
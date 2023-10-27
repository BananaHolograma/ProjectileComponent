<p align="center">
	<img width="256px" src="https://github.com/GodotParadise/ProjectileComponent/blob/main/icon.jpg" alt="GodotParadiseProjectileComponent logo" />
	<h1 align="center">Godot Paradise ProjectileComponent</h1>
	
[![LastCommit](https://img.shields.io/github/last-commit/GodotParadise/ProjectileComponent?cacheSeconds=600)](https://github.com/GodotParadise/ProjectileComponent/commits)
[![Stars](https://img.shields.io/github/stars/godotparadise/ProjectileComponent)](https://github.com/GodotParadise/ProjectileComponent/stargazers)
[![Total downloads](https://img.shields.io/github/downloads/GodotParadise/ProjectileComponent/total.svg?label=Downloads&logo=github&cacheSeconds=600)](https://github.com/GodotParadise/ProjectileComponent/releases)
[![License](https://img.shields.io/github/license/GodotParadise/ProjectileComponent?cacheSeconds=2592000)](https://github.com/GodotParadise/ProjectileComponent/blob/main/LICENSE.md)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat&logo=github)](https://github.com/godotparadise/ProjectileComponent/pulls)
[![](https://img.shields.io/discord/1167079890391138406.svg?label=&logo=discord&logoColor=ffffff&color=7389D8&labelColor=6A7EC2)](https://discord.gg/XqS7C34x)
</p>

[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/GodotParadise/ProjectileComponent/blob/main/README.md)

- - -

Imagine que coloca este componente en cualquier escena que represente un proyectil en su videojuego, y estará listo para la acción. Proporciona funcionalidades comunes para proyectiles estándar.

- [Requerimientos](#requerimientos)
- [✨Instalacion](#instalacion)
	- [Automatica (Recomendada)](#automatica-recomendada)
	- [Manual](#manual)
- [Como empezar](#como-empezar)
- [Parámetros exportados](#parámetros-exportados)
	- [Speed](#speed)
	- [Homing](#homing)
	- [Penetration](#penetration)
	- [Bounce](#bounce)
- [Variables normales accessibles](#variables-normales-accessibles)
- [Una vez entra en el scene tree](#una-vez-entra-en-el-scene-tree)
- [Funciones](#funciones)
	- [move(delta: float = get\_physics\_process\_delta\_time())](#movedelta-float--get_physics_process_delta_time)
	- [swap\_target(new\_target: Node2D)](#swap_targetnew_target-node2d)
	- [stop\_follow\_target()](#stop_follow_target)
	- [begin\_follow\_target(new\_target: Node2D)](#begin_follow_targetnew_target-node2d)
	- [target\_position() -\> Vector2](#target_position---vector2)
	- [update\_follow\_direction(on\_target: Node2D = target) -\> Vector2](#update_follow_directionon_target-node2d--target---vector2)
	- [bounce(new\_direction: Vector2) -\> Vector2](#bouncenew_direction-vector2---vector2)
- [Señales](#señales)
- [✌️Eres bienvenido a](#️eres-bienvenido-a)
- [🤝Normas de contribución](#normas-de-contribución)
- [📇Contáctanos](#contáctanos)

# Requerimientos
📢 No ofrecemos soporte para Godot 3+ ya que nos enfocamos en las versiones futuras estables a partir de la versión 4.
* Godot 4+

# ✨Instalacion
## Automatica (Recomendada)
Puedes descargar este plugin desde la [Godot asset library](https://godotengine.org/asset-library/asset/2039) oficial usando la pestaña AssetLib de tu editor Godot. Una vez instalado, estás listo para empezar
## Manual 
Para instalar manualmente el plugin, crea una carpeta **"addons"** en la raíz de tu proyecto Godot y luego descarga el contenido de la carpeta **"addons"** de este repositorio

# Como empezar
Este nodo funciona como los demás, sirviendo como hijo de otro nodo. En este caso, no está restringido sólo a `CharacterBody2D`, ya que las balas son típicamente nodos `Area2D`.

# Parámetros exportados
## Speed
- Max speed
- Acceleration
La **velocidad máxima**, como su nombre indica, define el límite máximo alcanzable de velocidad que se aplicará a la velocidad.
El getter de la velocidad modifica el valor basado en el parámetro `speed_reduction_on_penetration`.

La **aceleración** hace más suave alcanzar la velocidad máxima si quieres aumentar la fluidez del movimiento. En caso de que no la quieras simplemente asígnale un valor cero y el nodo alcanzará la velocidad máxima inmediatamente.

## Homing
- Homing distance
- Homing strength
La **homing distance** define la distancia máxima a la que el proyectil perseguirá al objetivo si éste está definido. **Déjalo a cero** si no hay límite de distancia.
El propósito de `homing_strength` es proporcionar un control preciso sobre la agresividad con la que el proyectil se acerca al objetivo.

## Penetration
- Max penetrations
- Speed reduction on penetration
El **max penetrations** es un valor entero que determina cuántas veces puede penetrar el proyectil antes de emitir la señal `penetration_complete`. No liberamos la cola del nodo ya que dejamos el comportamiento al usuario, permitiéndole manejarlo conectándose a la señal.
La **speed reduction on penetration** disminuye la velocidad en esta cantidad de vuelta a la velocidad máxima original cada vez que se produce una penetración.

## Bounce
- Bounce enabled
- Bounce times
El parámetro **bounce enabled** permite que el proyectil rebote en caso de colisión u otro tipo de evento. 
El parámetro **bounce times** determina el número de veces que este proyectil puede rebotar.

# Variables normales accessibles
- projectile: Node2D
- direction: Vector2
- target: Node2D
- follow_target: bool
- penetration_count
- bounced_positions: Array[Vector2]

# Una vez entra en el scene tree
- Se conecta a la señal `follow_started`.
Cuando este proyectil empieza a seguir un objetivo, el componente comprueba si el objetivo puede ser seguido. Esto significa
1. El objetivo no es nulo.
2. La distancia al objetivo es menor que el valor definido.
Si se cumplen estas condiciones, comienza el comportamiento de homing. Dependiendo de **`homing_strength`**, el proyectil empieza a seguir al objetivo suavemente.

# Funciones
## move(delta: float = get_physics_process_delta_time())
El proyectil comienza a moverse en la `direction` y a la `max speed` definidas como parámetros. En este estado, el proyectil utiliza `look_at` para orientarse hacia la dirección indicada.
## swap_target(new_target: Node2D)
El objetivo se intercambia con el proporcionado como parámetro y emite la señal `target_swapped`.
## stop_follow_target()
El proyectil deja de seguir al objetivo si éste está definido. Esta función establece el `target` a null y `follow_target` a false
## begin_follow_target(new_target: Node2D)
El proyectil comienza a seguir al objetivo y se activa este comportamiento. Esta función establece el objetivo a `new_target` y `follow_target` a true
## target_position() -> Vector2
Si se define un `target`, esta función devuelve la dirección normalizada desde este proyectil hasta el objetivo. Devuelve `Vector2.ZERO` cuando el `target` es nulo.
## update_follow_direction(on_target: Node2D = target) -> Vector2
Actualiza la dirección para seguir al objetivo si el proyectil está en modo seguimiento.
## bounce(new_direction: Vector2) -> Vector2
El proyectil rebota en la dirección definida por el parámetro `new_direction` si el rebote está activado y quedan rebotes para este proyectil. Cada rebote exitoso añade la posición a la matriz `bounced_positions`.
Normalmente, se pasa la `wall_normal` como parámetro para rebotar en la dirección opuesta, pero no queremos restringir las cosas; la `new_direction` es flexible. Esta acción también emite la señal `bounced`.

# Señales
- *follow_started(target:Node2D)* 
- *follow_stopped(target: Node2D)* 
- *target_swapped(current_target: Node2D, previous_target:Node2D)* 
- *homing_distance_reached()*
- *bounced(position: Vector2)*
- *penetrated(remaining_penetrations: int)* 
- *penetration_complete()*

# ✌️Eres bienvenido a
- [Give feedback](https://github.com/GodotParadise/ProjectileComponent/pulls)
- [Suggest improvements](https://github.com/GodotParadise/ProjectileComponent/issues/new?assignees=BananaHolograma&labels=enhancement&template=feature_request.md&title=)
- [Bug report](https://github.com/GodotParadise/ProjectileComponent/issues/new?assignees=BananaHolograma&labels=bug%2C+task&template=bug_report.md&title=)

GodotParadise esta disponible de forma gratuita.

Si estas agradecido por lo que hacemos, por favor, considera hacer una donación. Desarrollar los plugins y contenidos de GodotParadise requiere una gran cantidad de tiempo y conocimiento, especialmente cuando se trata de Godot. Incluso 1€ es muy apreciado y demuestra que te importa. ¡Muchas Gracias!

- - -
# 🤝Normas de contribución
**¡Gracias por tu interes en GodotParadise!**

Para garantizar un proceso de contribución fluido y colaborativo, revise nuestras [directrices de contribución](https://github.com/godotparadise/ProjectileComponent/blob/main/CONTRIBUTING.md) antes de empezar. Estas directrices describen las normas y expectativas que mantenemos en este proyecto.

**📓Código de conducta:** En este proyecto nos adherimos estrictamente al [Código de conducta de Godot](https://godotengine.org/code-of-conduct/). Como colaborador, es importante respetar y seguir este código para mantener una comunidad positiva e inclusiva.
- - -


# 📇Contáctanos
Si has construido un proyecto, demo, script o algun otro ejemplo usando nuestros plugins haznoslo saber y podemos publicarlo en este repositorio para ayudarnos a mejorar y saber que lo que hacemos es útil.

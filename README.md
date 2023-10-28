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

[![es](https://img.shields.io/badge/lang-es-yellow.svg)](https://github.com/GodotParadise/ProjectileComponent/blob/main/locale/README.es-ES.md)

- - -

Imagine placing this component in any scene representing a projectile in your video game, and it is ready for action. It provides common functionalities for standard projectiles.
- [Requirements](#requirements)
- [✨Installation](#installation)
	- [Automatic (Recommended)](#automatic-recommended)
	- [Manual](#manual)
	- [CSharp version](#csharp-version)
- [Getting started](#getting-started)
- [Exported parameters](#exported-parameters)
	- [Speed](#speed)
	- [Homing](#homing)
	- [Penetration](#penetration)
	- [Bounce](#bounce)
- [Accessible normal parameters](#accessible-normal-parameters)
- [Once upon the scene tree](#once-upon-the-scene-tree)
- [Functions](#functions)
	- [move(delta: float = get\_physics\_process\_delta\_time())](#movedelta-float--get_physics_process_delta_time)
	- [swap\_target(new\_target: Node2D)](#swap_targetnew_target-node2d)
	- [stop\_follow\_target()](#stop_follow_target)
	- [begin\_follow\_target(new\_target: Node2D)](#begin_follow_targetnew_target-node2d)
	- [target\_position() -\> Vector2](#target_position---vector2)
	- [update\_follow\_direction(on\_target: Node2D = target) -\> Vector2](#update_follow_directionon_target-node2d--target---vector2)
	- [bounce(new\_direction: Vector2) -\> Vector2](#bouncenew_direction-vector2---vector2)
- [Signals](#signals)
- [✌️You are welcome to](#️you-are-welcome-to)
- [🤝Contribution guidelines](#contribution-guidelines)
- [📇Contact us](#contact-us)

# Requirements
📢 We don't currently give support to Godot 3+ as we focus on future stable versions from version 4 onwards
* Godot 4+

# ✨Installation
## Automatic (Recommended)
You can download this plugin from the official [Godot asset library](https://godotengine.org/asset-library/asset/2039) using the AssetLib tab in your godot editor. Once installed, you're ready to get started
##  Manual 
To manually install the plugin, create an **"addons"** folder at the root of your Godot project and then download the contents from the **"addons"** folder of this repository
## CSharp version
This plugin has also been written in C# and you can find it on [ProjectileComponentCSharp](https://github.com/GodotParadise/ProjectileComponentCSharp)

# Getting started
This node functions like the others, serving as a child of another node. In this case, it is not restricted to only `CharacterBody2D`, as bullets are typically `Area2D` objects.

# Exported parameters
## Speed
- Max speed
- Acceleration
The **max speed** as the name say, defines the maximum reachable limit of speed that will be apply to the velocity. 

The getter of the speed modify the value based on `speed_reduction_on_penetration` parameter.

The **acceleration** makes smoother to reach the maximum speed if you want to increase the juiciness of the movement. In case you don't want it just assign a zero value to it and the node will reach the maximum speed immediately

## Homing
- Homing distance
- Homing strength
The **homing distance** defines the maximum distance the projectile will pursue the target if the target is defined. **Leave it at zero** if there is no distance limit.
The purpose of `homing_strength` is to provide fine-grained control over how aggressively the projectile homes in on the target.

## Penetration
- Max penetrations
- Speed reduction on penetration
The **max penetrations** is an integer value that determines how many times the projectile can penetrate before emitting the `penetration_complete` signal. We do not queue-free the node as we leave the behavior to the user, allowing them to handle it by connecting to the signal.
The **speed reduction on penetration** decreases the speed by this amount back to the original maximum speed each time a penetration occurs.

## Bounce
- Bounce enabled
- Bounce times
The **bounce enabled** setting allows the projectile to bounce upon collision or another type of event. 
The **bounce times** parameter determines the number of times this projectile can bounce.

# Accessible normal parameters
- projectile: Node2D
- direction: Vector2
- target: Node2D
- follow_target: bool
- penetration_count
- bounced_positions: Array[Vector2]

# Once upon the scene tree
- Connects to the signal `follow_started`
When this projectile starts to follow a target, the component checks if the target can be followed. This means:
1. The target is not null.
2. The homing distance to the target is less than the defined value.
If these conditions are met, the homing behavior begins. Depending on the **`homing_strength`**, the projectile starts to follow the target smoothly.

# Functions
## move(delta: float = get_physics_process_delta_time())
The projectile starts moving in the `direction` and at the `maximum speed` defined as parameters. In this state, the projectile uses `look_at` to orient itself towards the provided direction.
## swap_target(new_target: Node2D)
The target is swapped to the provided one as parameter and emit the signal `target_swapped`
## stop_follow_target()
The projectile stop following the target if this is defined. This function set the `target` to null and `follow_target` to false
## begin_follow_target(new_target: Node2D)
The projectile begins to follow the target, and this behavior is activated. This function set the target to `new_target` and `follow_target` to true
## target_position() -> Vector2
If a `target` is defined, this function returns the normalized direction from this projectile to the target. It returns `Vector2.ZERO` when the `target` is null.
## update_follow_direction(on_target: Node2D = target) -> Vector2
Update the direction to follow the target if the projectile is on following mode.
## bounce(new_direction: Vector2) -> Vector2
The projectile bounces in the direction defined by the `new_direction` parameter if bouncing is enabled and there are remaining bounces for this projectile. Every succesfull bounce append the position to the `bounced_positions` array
Typically, you pass the `wall_normal` as a parameter to bounce in the opposite direction, but we don't want to restrict things; the `new_direction` is flexible. This action also emits the `bounced` signal.


# Signals
- *follow_started(target:Node2D)* 
- *follow_stopped(target: Node2D)* 
- *target_swapped(current_target: Node2D, previous_target:Node2D)* 
- *homing_distance_reached()*
- *bounced(position: Vector2)*
- *penetrated(remaining_penetrations: int)* 
- *penetration_complete()*

# ✌️You are welcome to
- [Give feedback](https://github.com/GodotParadise/ProjectileComponent/pulls)
- [Suggest improvements](https://github.com/GodotParadise/ProjectileComponent/issues/new?assignees=BananaHolograma&labels=enhancement&template=feature_request.md&title=)
- [Bug report](https://github.com/GodotParadise/ProjectileComponent/issues/new?assignees=BananaHolograma&labels=bug%2C+task&template=bug_report.md&title=)

GodotParadise is available for free.

If you're grateful for what we're doing, please consider a donation. Developing GodotParadise requires massive amount of time and knowledge, especially when it comes to Godot. Even $1 is highly appreciated and shows that you care. Thank you!

- - -
# 🤝Contribution guidelines
**Thank you for your interest in Godot Paradise!**

To ensure a smooth and collaborative contribution process, please review our [contribution guidelines](https://github.com/GodotParadise/ProjectileComponent/blob/main/CONTRIBUTING.md) before getting started. These guidelines outline the standards and expectations we uphold in this project.

**📓Code of Conduct:** We strictly adhere to the [Godot code of conduct](https://godotengine.org/code-of-conduct/) in this project. As a contributor, it is important to respect and follow this code to maintain a positive and inclusive community.

- - -

# 📇Contact us
If you have built a project, demo, script or example with this plugin let us know and we can publish it here in the repository to help us to improve and to know that what we do is useful.

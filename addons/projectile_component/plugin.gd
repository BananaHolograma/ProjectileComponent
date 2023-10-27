@tool
extends EditorPlugin

const PLUGIN_PREFIX = "GodotParadise"


func _enter_tree():
	add_custom_type(_add_prefix("ProjectileComponent"), "Node2D", preload("res://addons/projectile_component/projectile_component.gd"), preload("res://addons/projectile_component/bow.png"));


func _exit_tree():
	remove_custom_type(_add_prefix("ProjectileComponent"))
	

func _add_prefix(text: String) -> String:
	return "{prefix}{text}".format({"prefix": PLUGIN_PREFIX, "text": text}).strip_edges()

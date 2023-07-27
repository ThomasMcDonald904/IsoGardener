extends Node2D

var game_time = 0

# Given in seconds per tick
var tick_speed = 1

var selected_crop = []

var crops_available = [[preload("res://Crops/wheat.tscn").instantiate(), 20], [preload("res://Crops/beans.tscn").instantiate(), 1], [preload("res://Crops/potato.tscn").instantiate(), 0]]

var mouse_on_ground = false

var sickle_equiped = false

var money = 0

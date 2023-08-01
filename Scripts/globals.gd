extends Node2D

var game_time = 0

# Given in seconds per tick
var tick_speed = 1

var selected_crop = []

var crops_available = []

var crops_in_market = [preload("res://Crops/wheat.tscn").instantiate(), 
						preload("res://Crops/beans.tscn").instantiate(), preload("res://Crops/potato.tscn").instantiate(),
						preload("res://Crops/pumpkin.tscn").instantiate()
						]

var mouse_on_ground = false

var sickle_equiped = false

var money = 10

# Grid cell structure: crop = [tile_pos, crop_reference, planting_time]
var grid = []
var diseased_grid = []

var input_count = 0


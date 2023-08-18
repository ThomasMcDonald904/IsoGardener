class_name BaseCrop
extends Node

@export var crop_name: String

@export var buy_price = 1
@export var sell_price = 1
@export var icon: Texture
@export var crop_tileset_row: int # Starting from 0

# Given in ticks passed
@export var age_1 = 20
@export var age_2 = 40
@export var age_3 = 55
@export var harvestable_age = 55

func isHarvestable(tick_age: float) -> bool:
	return tick_age >= harvestable_age

func onHarvest(ground: Ground, tile_pos: Vector2i, grid_idx: int):
	ground.set_cell(0, tile_pos, ground.get_cell_source_id(0, tile_pos), Vector2i(0, 0))
	globals.money += sell_price
	globals.grid.remove_at(grid_idx)

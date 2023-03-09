import os
import pygame

# Split the tile sheet into tiles of the wanted size
TILE_HEIGHT = 32
TILE_WIDTH = 16
tile_sheet = pygame.image.load("crops.png")
tile_sheet_width, tile_sheet_height = tile_sheet.get_size()
tileset = []
for tile_y in range(tile_sheet_height//TILE_HEIGHT):
    for tile_x in range(tile_sheet_width//TILE_WIDTH):
        rect = (tile_x*TILE_WIDTH, tile_y*TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT)
        tileset.append(tile_sheet.subsurface(rect))

# Save each used tile in a new directory
dir_name = 'Crops'
os.makedirs(dir_name, exist_ok=True)
for index, tile in enumerate(tileset):
    pygame.image.save(tile, os.path.join(dir_name, f"Crop {index}.png"))

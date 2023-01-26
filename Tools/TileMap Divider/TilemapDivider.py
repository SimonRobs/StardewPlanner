import os
import pygame

# Split the tile sheet into 16x16 tiles
TILE_SIZE = 16
tile_sheet = pygame.image.load("winter_outdoorsTileSheet.png")
tile_sheet_width, tile_sheet_height = tile_sheet.get_size()
tileset = []
for tile_y in range(tile_sheet_height//TILE_SIZE):
    for tile_x in range(tile_sheet_width//TILE_SIZE):
        rect = (tile_x*TILE_SIZE, tile_y*TILE_SIZE, TILE_SIZE, TILE_SIZE)
        tileset.append(tile_sheet.subsurface(rect))

# Save each used tile in a new directory
dir_name = 'Winter Outdoors'
os.makedirs(dir_name, exist_ok=True)
for index, tile in enumerate(tileset):
    pygame.image.save(tile, os.path.join(dir_name, f"Winter {index}.png"))

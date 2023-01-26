import pygame
import os

TILE_SIZE = 16
INSET_SIZE = 4
INSET_OFFSET = TILE_SIZE - INSET_SIZE

def create_tiles(for_winter = False):

    TILE_TYPES = [
        f"{'Winter ' if for_winter else ''}Wood Floor",
        f"{'Winter ' if for_winter else ''}Stone Floor",
        f"{'Winter ' if for_winter else ''}Weathered Floor",
        f"{'Winter ' if for_winter else ''}Crystal Floor",
        f"{'Winter ' if for_winter else ''}Straw Floor",
        f"{'Winter ' if for_winter else ''}Gravel Path",
        f"{'Winter ' if for_winter else ''}Wood Path",
        f"{'Winter ' if for_winter else ''}Crystal Path",
        f"{'Winter ' if for_winter else ''}Cobblestone Path",
        f"{'Winter ' if for_winter else ''}Stepping Stone Path",
        f"{'Winter ' if for_winter else ''}Brick Floor",
        f"{'Winter ' if for_winter else ''}Rustic Plank Floor",
        f"{'Winter ' if for_winter else ''}Stone Walkway Floor",
    ]

    flooring_tile_map = pygame.image.load(f"flooring{'_winter' if for_winter else ''}.png")
    tile_map_width, tile_map_height = flooring_tile_map.get_size()
    tileset = []
    for tile_x in range(tile_map_width//TILE_SIZE):
        line = []
        tileset.append(line)
        for tile_y in range(tile_map_height//TILE_SIZE):
            rect = (tile_x*TILE_SIZE, tile_y*TILE_SIZE, TILE_SIZE, TILE_SIZE)
            line.append(flooring_tile_map.subsurface(rect))

    default_directions = [
        "Center Solo",
        "Horizontal Upper Edges",
        "Horizontal Edges",
        "Horizontal Lower Edges",
        "Upper Left Edge",
        "Left Edge",
        "Lower Left Edge",
        "Vertical Left Edges",
        "Up Edge",
        "Center",
        "Down Edge",
        "Vertical Edges",
        "Upper Right Edge",
        "Right Edge",
        "Lower Right Edge",
        "Vertical Right Edges"
    ]

    tile_index = 0
    for tile_name in TILE_TYPES:
        os.makedirs(tile_name, exist_ok=True)
        
        # Get the tile type's start offset
        start_offset = (tile_index // 4 * 4, (tile_index % 4) * 4)

        # Create the tiles from the original tilemap
        for i in range(0, 4):
            for j in range(0, 4):
                pygame.image.save(tileset[start_offset[1] + i][start_offset[0] + j], os.path.join(tile_name, f"{tile_name} {default_directions[i*4 + j]}.png"))

        # Get the definitions for the insets
        # [0]: pygame surface for the inset
        # [1]: Expected position of the inset
        bottom_right_inset = (tileset[start_offset[1] + 1][start_offset[0] + 0].subsurface(     0,            0,       INSET_SIZE, INSET_SIZE), (INSET_OFFSET, INSET_OFFSET))
        bottom_left_inset  = (tileset[start_offset[1] + 3][start_offset[0] + 0].subsurface(INSET_OFFSET,      0,       INSET_SIZE, INSET_SIZE), (     0,       INSET_OFFSET))
        top_right_inset    = (tileset[start_offset[1] + 1][start_offset[0] + 2].subsurface(     0,       INSET_OFFSET, INSET_SIZE, INSET_SIZE), (INSET_OFFSET,      0      ))
        top_left_inset     = (tileset[start_offset[1] + 3][start_offset[0] + 2].subsurface(INSET_OFFSET, INSET_OFFSET, INSET_SIZE, INSET_SIZE), (     0,            0      ))

        # Corners with Inset
        corner = tileset[start_offset[1] + 1][start_offset[0] + 0].copy()
        corner.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(corner, os.path.join(tile_name, f"{tile_name} Upper Left Edge Inset.png"))

        corner = tileset[start_offset[1] + 3][start_offset[0] + 0].copy()
        corner.blit(bottom_left_inset[0], bottom_left_inset[1])
        pygame.image.save(corner, os.path.join(tile_name, f"{tile_name} Upper Right Edge Inset.png"))

        corner = tileset[start_offset[1] + 1][start_offset[0] + 2].copy()
        corner.blit(top_right_inset[0], top_right_inset[1])
        pygame.image.save(corner, os.path.join(tile_name, f"{tile_name} Lower Left Edge Inset.png"))

        corner = tileset[start_offset[1] + 3][start_offset[0] + 2].copy()
        corner.blit(top_left_inset[0], top_left_inset[1])
        pygame.image.save(corner, os.path.join(tile_name, f"{tile_name} Lower Right Edge Inset.png"))

        # Edges with Inset
        up_edge = tileset[start_offset[1] + 2][start_offset[0] + 0].copy()
        up_edge.blit(bottom_left_inset[0], bottom_left_inset[1])
        pygame.image.save(up_edge, os.path.join(tile_name, f"{tile_name} Up Edge Left Inset.png"))
        up_edge = tileset[start_offset[1] + 2][start_offset[0] + 0].copy()
        up_edge.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(up_edge, os.path.join(tile_name, f"{tile_name} Up Edge Right Inset.png"))
        up_edge = tileset[start_offset[1] + 2][start_offset[0] + 0].copy()
        up_edge.blit(bottom_left_inset[0], bottom_left_inset[1])
        up_edge.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(up_edge, os.path.join(tile_name, f"{tile_name} Up Edge Double Inset.png"))

        down_edge = tileset[start_offset[1] + 2][start_offset[0] + 2].copy()
        down_edge.blit(top_left_inset[0], top_left_inset[1])
        pygame.image.save(down_edge, os.path.join(tile_name, f"{tile_name} Down Edge Left Inset.png"))
        down_edge = tileset[start_offset[1] + 2][start_offset[0] + 2].copy()
        down_edge.blit(top_right_inset[0], top_right_inset[1])
        pygame.image.save(down_edge, os.path.join(tile_name, f"{tile_name} Down Edge Right Inset.png"))
        down_edge = tileset[start_offset[1] + 2][start_offset[0] + 2].copy()
        down_edge.blit(top_left_inset[0], top_left_inset[1])
        down_edge.blit(top_right_inset[0], top_right_inset[1])
        pygame.image.save(down_edge, os.path.join(tile_name, f"{tile_name} Down Edge Double Inset.png"))

        left_edge = tileset[start_offset[1] + 1][start_offset[0] + 1].copy()
        left_edge.blit(top_right_inset[0], top_right_inset[1])
        pygame.image.save(left_edge, os.path.join(tile_name, f"{tile_name} Left Edge Upper Inset.png"))
        left_edge = tileset[start_offset[1] + 1][start_offset[0] + 1].copy()
        left_edge.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(left_edge, os.path.join(tile_name, f"{tile_name} Left Edge Lower Inset.png"))
        left_edge = tileset[start_offset[1] + 1][start_offset[0] + 1].copy()
        left_edge.blit(top_right_inset[0], top_right_inset[1])
        left_edge.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(left_edge, os.path.join(tile_name, f"{tile_name} Left Edge Double Inset.png"))

        right_edge = tileset[start_offset[1] + 3][start_offset[0] + 1].copy()
        right_edge.blit(top_left_inset[0], top_left_inset[1])
        pygame.image.save(right_edge, os.path.join(tile_name, f"{tile_name} Right Edge Upper Inset.png"))
        right_edge = tileset[start_offset[1] + 3][start_offset[0] + 1].copy()
        right_edge.blit(bottom_left_inset[0], bottom_left_inset[1])
        pygame.image.save(right_edge, os.path.join(tile_name, f"{tile_name} Right Edge Lower Inset.png"))
        right_edge = tileset[start_offset[1] + 3][start_offset[0] + 1].copy()
        right_edge.blit(top_left_inset[0], top_left_inset[1])
        right_edge.blit(bottom_left_inset[0], bottom_left_inset[1])
        pygame.image.save(right_edge, os.path.join(tile_name, f"{tile_name} Right Edge Double Inset.png"))


        # Centres with Single Inset
        original_center = tileset[start_offset[1] + 2][start_offset[0] + 1]
        center = original_center.copy()
        center.blit(top_right_inset[0], top_right_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Upper Right Inset.png"))

        center = original_center.copy()
        center.blit(top_left_inset[0], top_left_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Upper Left Inset.png"))

        center = original_center.copy()
        center.blit(bottom_left_inset[0], bottom_left_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Lower Left Inset.png"))

        center = original_center.copy()
        center.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Lower Right Inset.png"))


        # Centres with Double Insets
        center = original_center.copy()
        center.blit(top_right_inset[0], top_right_inset[1])
        center.blit(top_left_inset[0], top_left_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Up Double Inset.png"))

        center = original_center.copy()
        center.blit(bottom_left_inset[0], bottom_left_inset[1])
        center.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Down Double Inset.png"))
        
        center = original_center.copy()
        center.blit(top_left_inset[0], top_left_inset[1])
        center.blit(bottom_left_inset[0], bottom_left_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Left Double Inset.png"))
        
        center = original_center.copy()
        center.blit(top_right_inset[0], top_right_inset[1])
        center.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Right Double Inset.png"))
        
        # Centres with Diagonal Insets
        center = original_center.copy()
        center.blit(bottom_right_inset[0], bottom_right_inset[1])
        center.blit(top_left_inset[0], top_left_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Lower Right Upper Left Double Inset.png"))
        
        center = original_center.copy()
        center.blit(bottom_left_inset[0], bottom_left_inset[1])
        center.blit(top_right_inset[0], top_right_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Lower Left Upper Right Double Inset.png"))

        # Centres with Triple Insets
        center = original_center.copy()
        center.blit(top_right_inset[0], top_right_inset[1])
        center.blit(top_left_inset[0], top_left_inset[1])
        center.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Up Right Triple Inset.png"))

        center = original_center.copy()
        center.blit(top_right_inset[0], top_right_inset[1])
        center.blit(top_left_inset[0], top_left_inset[1])
        center.blit(bottom_left_inset[0], bottom_left_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Up Left Triple Inset.png"))
        
        center = original_center.copy()
        center.blit(top_right_inset[0], top_right_inset[1])
        center.blit(bottom_left_inset[0], bottom_left_inset[1])
        center.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Lower Right Triple Inset.png"))
        
        center = original_center.copy()
        center.blit(top_left_inset[0], top_left_inset[1])
        center.blit(bottom_left_inset[0], bottom_left_inset[1])
        center.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Lower Left Triple Inset.png"))
        

        # Centres with Quadruple Insets
        center = original_center.copy()
        center.blit(top_left_inset[0], top_left_inset[1])
        center.blit(top_right_inset[0], top_right_inset[1])
        center.blit(bottom_left_inset[0], bottom_left_inset[1])
        center.blit(bottom_right_inset[0], bottom_right_inset[1])
        pygame.image.save(center, os.path.join(tile_name, f"{tile_name} Quadruple Inset.png"))

        tile_index += 1

create_tiles()
create_tiles(for_winter=True)

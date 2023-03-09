import os
import pygame

images = [
    "Tulip.png",
    "Blue Jazz.png",
    "Poppy.png",
    "Summer Spangle.png",
    "Fairy Rose.png",
]

all_tints = {
    0: [
        (255, 186, 255),
        (223, 191, 255),
        (255, 246, 0),
        (255, 80, 0),
        (255, 158, 193)
    ],

    1: [
        (35, 127, 255),
        (109, 131, 255),
        (112, 207, 255),
        (191, 228, 255),
        (94, 121, 255),
        (40, 150, 255)
    ],

    2: [
        (255, 0, 0),
        (254, 254, 254),
        (255, 170, 0)
    ],

    3: [
        (0, 208, 255),
        (99, 255, 210),
        (255, 212, 0),
        (255, 144, 122),
        (255, 0, 238),
        (206, 91, 255)
    ],

    4: [
        (187, 0, 255),
        (119, 137, 255),
        (71, 227, 255),
        (255, 127, 144),
        (205, 178, 255),
        (140, 119, 255)
    ],

}

dir_name = "res"
os.makedirs(dir_name, exist_ok=True)

for i, image_name in enumerate(images):
    for j, tint in enumerate(all_tints[i]):
        image = pygame.image.load(image_name)
        image.fill(tint, special_flags=pygame.BLEND_MULT)
        pygame.image.save(image, os.path.join(dir_name, f"{j}{image_name}"))

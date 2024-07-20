#pragma once

#include <SDL.h>
#include <glm/vec2.hpp>
#include <glm/vec4.hpp>

typedef struct render_state
{
    SDL_Window* window;
    uint32_t width;
    uint32_t height;
} Render_State;

void render_init();
void render_begin();
void render_end();
void render_quad(glm::vec2 pos, glm::vec2 size, glm::vec4 color);
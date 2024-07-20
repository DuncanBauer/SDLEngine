#pragma once

#include <SDL.h>

#include "render.h"

typedef struct render_state_internal {
    uint32_t vao_quad;
    uint32_t vbo_quad;
    uint32_t ebo_quad;
} Render_State_Internal;

SDL_Window* render_init_window(uint32_t width, uint32_t height);
void render_init_quad(uint32_t* vao_quad, uint32_t* vbo_quad, uint32_t* ebo_quad);
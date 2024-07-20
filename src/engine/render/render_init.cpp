#include <glad/glad.h>
#include <SDL.h>
#include <iostream>

#include "../global.h"
#include "../logger.h"
#include "render.h"
#include "render_internal.h"

SDL_Window* render_init_window(uint32_t width, uint32_t height)
{
    // Setup SDL
    if (SDL_Init(SDL_INIT_VIDEO) != 0)
    {
        std::cerr << "Error: SDL_Init(): " << SDL_GetError();
        return nullptr;
    }

    Uint32 window_flags = SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE | SDL_WINDOW_HIDDEN;
    SDL_Window* window = SDL_CreateWindow("SDL Engine", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 1280, 720, window_flags);

    if (window == nullptr)
    {
        std::cerr << "Error: SDL_CreateWindow(): " << SDL_GetError();
        return nullptr;
    }

    SDL_SetWindowPosition(window, SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED);
    SDL_GLContext gl_context = SDL_GL_CreateContext(window);
    if (!gladLoadGLLoader((GLADloadproc)SDL_GL_GetProcAddress)) {
        std::cerr << "Failed to load GL: " << SDL_GetError();
    }

    SDL_GL_MakeCurrent(window, gl_context);
    SDL_GL_SetSwapInterval(1); // Enable vsync
    SDL_ShowWindow(window);

    printf("OpenGL Loaded");
    printf("Vendor: %s", glGetString(GL_VENDOR));
    printf("Renderer: %s", glGetString(GL_RENDERER));
    printf("Version: %s", glGetString(GL_VERSION));
    
    return window;
}

void render_init_quad(uint32_t* vao, uint32_t* vbo, uint32_t* ebo)
{//        x,    y, z, u, v
    float vertices[] = {
         0.5,  0.5, 0, 0, 0,
         0.5, -0.5, 0, 0, 1,
        -0.5, -0.5, 0, 1, 1,
        -0.5,  0.5, 0, 1, 0
    };

    uint32_t indices[] = {
        0, 1, 3,
        1, 2, 3
    };

    glGenVertexArrays(1, vao);
    glGenBuffers(1, vbo);
    glGenBuffers(1, ebo);

    glBindVertexArray(*vao);

    glBindBuffer(GL_ARRAY_BUFFER, *vbo);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, *ebo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

    // xyz
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(float), NULL);
    glEnableVertexAttribArray(0);

    // uv
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void*)(3 * sizeof(float)));
    glad_glEnableVertexAttribArray(1);

    glBindVertexArray(0);
}
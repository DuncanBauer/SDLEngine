#include <SDL.h>
#include <glad/glad.h>

#include "engine/render/render.h"
#include "engine/global.h"

// Main code
int main(int argc, char** argv)
{
    render_init();

    bool quit = false;

    while (!quit)
    {
        SDL_Event event;
        while (SDL_PollEvent(&event))
        {
            switch (event.type)
            {
            case SDL_QUIT:
                quit = true;
                break;
            default:
                break;
            }
        }

        render_begin();
        render_quad(
            (glm::vec2) (global.render.width * 0.5, global.render.height * 0.5),
            (glm::vec2) (50, 50),
            (glm::vec4) (1, 1, 1, 1)
        );
        render_end();
    }

    return 0;
}
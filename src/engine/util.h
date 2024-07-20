#pragma once

#define ERROR_EXIT(...) fprintf(stderr, __VA_ARGS__); return
#define ERROR_RETURN(R, ...) fprintf(stderr, __VA_ARGS__); return R
#pragma once

#include <spdlog/spdlog.h>
#include <spdlog/fmt/ostr.h>
#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/sinks/basic_file_sink.h>

class Logger
{
public:
    static void init();

    static inline std::shared_ptr<spdlog::logger>& getEngineLogger() { return m_engineLogger; }

private:
    static std::shared_ptr<spdlog::logger> m_engineLogger;
};

#ifdef DEBUG
// SPDLog Macros for the ENGINE Library
#define ENGINE_TRACE(...)    ::Logger::getEngineLogger()->trace(__VA_ARGS__)
#define ENGINE_INFO(...)     ::Logger::getEngineLogger()->info(__VA_ARGS__)
#define ENGINE_WARN(...)     ::Logger::getEngineLogger()->warn(__VA_ARGS__)
#define ENGINE_ERROR(...)    ::Logger::getEngineLogger()->error(__VA_ARGS__)
#define ENGINE_CRITICAL(...) ::Logger::getEngineLogger()->critical(__VA_ARGS__)
#else
// SPDLog Macros for the ENGINE Library
#define ENGINE_TRACE(...)
#define ENGINE_INFO(...)
#define ENGINE_WARN(...)
#define ENGINE_ERROR(...)
#define ENGINE_CRITICAL(...)
#endif

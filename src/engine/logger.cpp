#include "Logger.h"

std::shared_ptr<spdlog::logger> Logger::m_engineLogger;

void Logger::init()
{
    std::vector<spdlog::sink_ptr> logSinks;
    logSinks.emplace_back(std::make_shared<spdlog::sinks::stdout_color_sink_mt>());
    logSinks.emplace_back(std::make_shared<spdlog::sinks::basic_file_sink_mt>("ENGINE.log", true));

    logSinks[0]->set_pattern("%^[%T] %n: %v%$");
    logSinks[1]->set_pattern("[%T] [%l] %n: %v");

    m_engineLogger = std::make_shared<spdlog::logger>("ENGINE", begin(logSinks), end(logSinks));
    spdlog::register_logger(m_engineLogger);
    m_engineLogger->set_level(spdlog::level::trace);
    m_engineLogger->flush_on(spdlog::level::trace);
}

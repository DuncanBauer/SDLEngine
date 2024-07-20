workspace "SDLEngine"
	configurations
	{
		"Debug",
		"Release"
	}
	platforms
	{
		"Windows",
		"Unix"
	}

outputdir = "%{cfg.buildcfg}/%{cfg.system}"

-- Include dirs relative to root folder
IncludeDir = {}
IncludeDir["glad"]			= "Vendor/glad/include"
IncludeDir["glm"]			= "Vendor/glm"
IncludeDir["ImGui"]			= "Vendor/imgui"
IncludeDir["ImGuiBackends"]	= "Vendor/imgui/backends"
IncludeDir["SDL2"]			= "Vendor/SDL/include"
IncludeDir["spdlog"]		= "Vendor/spdlog/include"

LinkDir = {}
LinkDir["glm"] 	= "Vendor/glm/build/glm/%{cfg.buildcfg}/glm"
LinkDir["SDL2"] = "Vendor/SDL/build/%{cfg.buildcfg}/SDL2"
LinkDir["SDL2d"] = "Vendor/SDL/build/%{cfg.buildcfg}/SDL2d"
LinkDir["SDL2main"] = "Vendor/SDL/build/%{cfg.buildcfg}/SDL2main"
LinkDir["SDL2maind"] = "Vendor/SDL/build/%{cfg.buildcfg}/SDL2maind"

project "SDLEngine"
	location "."
	kind "ConsoleApp"
	staticruntime "off"
	language "C++"
	cppdialect "C++20"
	targetdir ("bin/" .. outputdir)
	objdir ("bin-int/" .. outputdir)

	files
	{
		"src/**.cpp",
		"src/**.h",

		"Vendor/glad/src/glad.c",
	}

	includedirs
	{
		"%{IncludeDir.glad}",
		"%{IncludeDir.glm}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.ImGuiBackends}",
		"%{IncludeDir.SDL2}",
		"%{IncludeDir.spdlog}"
	}

	links
	{
		"%{LinkDir.glm}",
	}

	filter "system:windows"
		architecture "x86_64"
		defines 
		{
			"_WIN32_WINNT=0x0601"
		}
		links
		{
			"OpenGL32"
		}

	filter "system:linux"
		architecture "x86_64"
		links
		{
			"GL"
		}

	filter "configurations:Debug"
      	defines 
		{
			"DEBUG"
		}
		links
		{
			"%{LinkDir.SDL2d}",
			"%{LinkDir.SDL2maind}"
		}
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
      	defines
		{
			"NDEBUG"
		}
		links
		{
			"%{LinkDir.SDL2}",
			"%{LinkDir.SDL2main}"
		}
		runtime "Release"
		optimize "on"
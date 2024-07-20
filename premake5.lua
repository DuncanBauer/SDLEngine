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
IncludeDir["SDL3"]			= "Vendor/SDL/include"
IncludeDir["spdlog"]		= "Vendor/spdlog/include"

LinkDir = {}
LinkDir["glm"] 	= "Vendor/glm/build/glm/%{cfg.buildcfg}/glm"
LinkDir["SDL3"] = "Vendor/SDL/build/%{cfg.buildcfg}/SDL3"

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
		
		"Vendor/imgui/*.cpp",
		-- "Vendor/imgui/*.h",
		
		-- Include required imgui classes for SDL3 and OpenGL
		"Vendor/imgui/backends/imgui_impl_sdl3.cpp",
		-- "Vendor/imgui/backends/imgui_impl_sdl3.h",
		"Vendor/imgui/backends/imgui_impl_opengl3.cpp",
		-- "Vendor/imgui/backends/imgui_impl_opengl3.h",
		-- "Vendor/imgui/backends/imgui_impl_opengl3_loader.h",
	}

	includedirs
	{
		"%{IncludeDir.glad}",
		"%{IncludeDir.glm}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.ImGuiBackends}",
		"%{IncludeDir.SDL3}",
		"%{IncludeDir.spdlog}"
	}

	links
	{
		"%{LinkDir.glm}",
		"%{LinkDir.SDL3}"
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
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
      	defines
		{
			"NDEBUG"
		}
		runtime "Release"
		optimize "on"
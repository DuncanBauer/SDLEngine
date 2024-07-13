workspace "ImGuiTemplate"
	architecture "x64"
	configurations
	{
		"Debug",
		"Release"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include dirs relative to root folder
IncludeDir = {}
IncludeDir["ImGui"]  = "Vendor/imgui"
IncludeDir["ImGuiBackends"]  = "Vendor/imgui/backends"
IncludeDir["SDL3"] = "Vendor/SDL/include"

LinkDir = {}
LinkDir["SDL3"] = "Vendor/SDL/build/Release/SDL3"

project "ImGuiTemplate"
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
		"Vendor/imgui/*.cpp",
		"Vendor/imgui/*.h",
		"Vendor/imgui/backends/imgui_impl_sdl3.cpp",
		"Vendor/imgui/backends/imgui_impl_sdl3.h",
		"Vendor/imgui/backends/imgui_impl_opengl3.cpp",
		"Vendor/imgui/backends/imgui_impl_opengl3.h",
		"Vendor/imgui/backends/imgui_impl_opengl3_loader.h",
	}

	includedirs
	{
		"%{IncludeDir.SDL3}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.ImGuiBackends}",
	}

	links
	{
		"%{LinkDir.SDL3}"
	}
		
	filter { "system:windows" }
		links { "OpenGL32" }

	filter { "system:not windows" }
		links { "GL" }

	filter "configurations:Debug"
		defines "PA_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "PA_RELEASE"
		runtime "Release"
		optimize "on"
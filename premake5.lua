workspace "ImGuiSDLTemplate"
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
IncludeDir["ImGui"]  = "Vendor/imgui"
IncludeDir["ImGuiBackends"]  = "Vendor/imgui/backends"
IncludeDir["SDL3"] = "Vendor/SDL/include"

LinkDir = {}
LinkDir["SDL3"] = "Vendor/SDL/build/Release/SDL3" -- Links static library for SDL3

project "ImGuiSDLTemplate"
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
		-- Include required imgui classes for SDL3 and OpenGL
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
		architecture "x86_64"
		links { "OpenGL32" }

	filter { "system:linux" }
		architecture "x86_64"
		links { "GL" }

	filter "configurations:Debug"
		defines "PA_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "PA_RELEASE"
		runtime "Release"
		optimize "on"
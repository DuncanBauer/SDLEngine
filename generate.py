import platform
import os
import subprocess
import shutil

root_directory = os.getcwd()

# Move to SDL3 build directory
os.chdir("Vendor/SDL")
if not os.path.exists("build"):
    os.mkdir("build")
os.chdir("build")

# Build SDL3 libraries
subprocess.run(["cmake", "-DCMAKE_BUILD_TYPE=RELEASE", ".."])
subprocess.run(["cmake", "--build", ".", "--config", "Release"])

# Return to root directory
os.chdir(root_directory)

# Create vs2022 solution
subprocess.run(["Vendor/binaries/premake5.exe", "vs2022"])

# Create executables
subprocess.run(["MSBuild", "ImGuiSDLTemplate.sln", "/p:Configuration=Release"])

# Copy SDL3 shared library to project build folders
if platform.system() == "Windows":
    src = os.path.join(root_directory, "Vendor/SDL/build/Release/SDL3.dll")
    dest = os.path.join(root_directory, "bin/Release/windows/SDL3.dll")
    shutil.copyfile(src, dest)
else:
    src = root_directory + "Vendor/SDL/build/Release/SDL3.dll"
    dest = root_directory + "bin/Release/linux/SDL3.dll"
    shutil.copyfile(src, dest)
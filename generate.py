import platform
import os
import subprocess
import shutil
import sys

root_directory = os.getcwd()
config = sys.argv[1]

# Move to SDL3 build directory
os.chdir("Vendor/SDL")
if not os.path.exists("build"):
    os.mkdir("build")
os.chdir("build")

# Build SDL3 libraries
subprocess.run(["cmake", "-DCMAKE_BUILD_TYPE={}".format(config), ".."])
subprocess.run(["cmake", "--build", ".", "--config", "{}".format(config)])

# Return to root directory
os.chdir(root_directory)


# Move to glm build directory
os.chdir("Vendor/glm")
if not os.path.exists("build"):
    os.mkdir("build")
os.chdir("build")

# Build SDL3 libraries
subprocess.run(["cmake", "-DCMAKE_BUILD_TYPE={}".format(config), ".."])
subprocess.run(["cmake", "--build", ".", "--config", "{}".format(config)])

# Return to root directory
os.chdir(root_directory)


# Create vs2022 solution
if platform.system() == "Windows":
    subprocess.run(["Vendor/binaries/premake5.exe", "vs2022"])


# Create executables
subprocess.run(["MSBuild", "SDLEngine.sln", "/p:Configuration={}".format(config)])


# Copy SDL3 shared library to project build folders
if platform.system() == "Windows":
    src = os.path.join(root_directory, "Vendor/SDL/build/{}/SDL3.dll".format(config))
    dest = os.path.join(root_directory, "bin/{}/windows/SDL3.dll").format(config)
    shutil.copyfile(src, dest)
else:
    src = root_directory + "Vendor/SDL/build/{}/SDL3.dll".format(config)
    dest = root_directory + "bin/{}/linux/SDL3.dll".format(config)
    shutil.copyfile(src, dest)
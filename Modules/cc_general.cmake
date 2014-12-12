# 
#  Copyright (c) 2011 Claus Christmann.
#  All rights reserved.
# 
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
# 
#      1) Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#      2) Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
# 
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
#  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#  POSSIBILITY OF SUCH DAMAGE.
#

#
# Prepare my personal environment
# ===============================
#


set( CC_PROJECTS_DIR ${_cc_projects_DIR} CACHE PATH "The absolute path to my code projects on this machine." )
set( CMAKE_INSTALL_PREFIX ${CC_PROJECTS_DIR} )

list(APPEND CMAKE_PREFIX_PATH ${CC_PROJECTS_DIR} )
list(APPEND CMAKE_MODULE_PATH 
  ${CC_PROJECTS_DIR}/CMake/Modules
  ${CC_PROJECTS_DIR}/AMG  
  ${CC_PROJECTS_DIR}/3rdParty/visilibity
  ${CC_PROJECTS_DIR}/3rdParty/clipper
  ${CC_PROJECTS_DIR}/3rdParty/VRONI/libvroni/
  ${CC_PROJECTS_DIR}/3rdParty/eigen/cmake
)
# Load my macros 
include(cc_macros)

# Announce that we made some fairly large alterations to the CMAKE_MODULE_PATH
message(STATUS "The CMAKE_MODULE_PATH has been altered. Please DOUBLE CHECK it:")
message_variable(CMAKE_MODULE_PATH)

#
# 32/64 bit setup
# ===============
#
if( CMAKE_SIZEOF_VOID_P EQUAL 4 )
  # this is a 32bit machine
  set( HAVE_64_BIT OFF )
else()
  # this is a 64bit machine
  message(STATUS "CMake detected this machine to be 64bit.")
  set( HAVE_64_BIT ON )
endif()
mark_as_advanced( HAVE_64_BIT )

if(HAVE_64_BIT)
  option(BUILD_NATIVE_64_BIT "Do you want to build a native 64bit target?" ON)
endif(HAVE_64_BIT)

if( BUILD_NATIVE_64_BIT )
  message( STATUS "Configuring to build a native 64bit target.")
  set_property(GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS ON)
else( BUILD_NATIVE_64_BIT )
  message( STATUS "Configuring to build a 32bit target on a 64bit system.")
  set_property(GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS OFF     )
#   set_property(GLOBAL PROPERTY COMPILE_FLAGS                "-m32"  )
#   set_property(GLOBAL PROPERTY LINK_FLAGS                   "-m32"  )
  add_definitions(-m32)
  set( CMAKE_EXE_LINKER_FLAGS  "-m32")
  set( CMAKE_SHARED_LINKER_FLAGS  "-m32")
  set( CMAKE_MODULE_LINKER_FLAGS  "-m32")
  set( CMAKE_LINKER_FLAGS "-m32")
#   message_variable(CMAKE_CXX_FLAGS)
#   message_variable(CMAKE_EXE_LINKER_FLAGS)
#   message_variable(CMAKE_SHARED_LINKER_FLAGS)
#   message_variable(CMAKE_MODULE_LINKER_FLAGS)
#   message_variable(LINK_FLAGS)

endif( BUILD_NATIVE_64_BIT )

#
# Prepare install target locations
# ================================
#

set(_cc_dest_BIN         "bin")
set(_cc_dest_LIB         "lib")
set(_cc_dest_ARCHIVE     "lib")
set(_cc_dest_INCLUDE     "include")

set(_cc_dest_BIN_64      "bin")
set(_cc_dest_LIB_64      "lib64")
set(_cc_dest_ARCHIVE_64  "lib64")
set(_cc_dest_INCLUDE_64  "include")

mark_as_advanced(
  _cc_dest_BIN
  _cc_dest_LIB
  _cc_dest_ARCHIVE
  _cc_dest_INCLUDE
  _cc_dest_BIN_64
  _cc_dest_LIB_64
  _cc_dest_ARCHIVE_64
  _cc_dest_INCLUDE_64
)



if( BUILD_NATIVE_64_BIT )
  set( runtime_DIR ${_cc_dest_BIN_64}     CACHE STRING "The binary installation location, relative to CMAKE_INSTALL_PREFIX.")
  set( library_DIR ${_cc_dest_LIB_64}     CACHE STRING "The dynamic library installation location, relative to CMAKE_INSTALL_PREFIX.")
  set( archive_DIR ${_cc_dest_ARCHIVE_64} CACHE STRING "The static library installation location, relative to CMAKE_INSTALL_PREFIX.")
  set( headers_DIR ${_cc_dest_INCLUDE_64} CACHE STRING "The header installation location, relative to CMAKE_INSTALL_PREFIX.")
else( BUILD_NATIVE_64_BIT )
  set( runtime_DIR ${_cc_dest_BIN}     CACHE STRING "The binary installation location, relative to CMAKE_INSTALL_PREFIX.")
  set( library_DIR ${_cc_dest_LIB}      CACHE STRING "The dynamic library installation location, relative to CMAKE_INSTALL_PREFIX.")
  set( archive_DIR ${_cc_dest_ARCHIVE}  CACHE STRING "The static library installation location, relative to CMAKE_INSTALL_PREFIX.")
  set( headers_DIR ${_cc_dest_INCLUDE}  CACHE STRING "The header installation location, relative to CMAKE_INSTALL_PREFIX.")
endif( BUILD_NATIVE_64_BIT )









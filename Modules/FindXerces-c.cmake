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
# Find the include directory
# =======================
#
find_path(XERCESC_INCLUDE_DIR xercesc/parsers/SAXParser.hpp)

#debug output
if( NOT Xerces-c_FIND_QUIETLY )
  if( NOT XERCESC_INCLUDE_DIR )
    message(SEND_ERROR ${XERCESC_INCLUDE_DIR})
  else( NOT Xerces-c_FIND_QUIETLY )
    message(STATUS "Xerces-c include directory is " ${XERCESC_INCLUDE_DIR} )
  endif( NOT XERCESC_INCLUDE_DIR )
endif( NOT Xerces-c_FIND_QUIETLY )


#
# Find the actual library
# =======================
#
find_library(XERCESC_Xerces-c_LIBRARY xerces-c)

# debug output
if( NOT Xerces-c_FIND_QUIETLY )
  if( NOT XERCESC_Xerces-c_LIBRARY )
    message(SEND_ERROR ${XERCESC_Xerces-c_LIBRARY})
  else( NOT XERCESC_Xerces-c_LIBRARY )
    message(STATUS "Xerces-c has been found as " ${XERCESC_Xerces-c_LIBRARY} )
  endif( NOT XERCESC_Xerces-c_LIBRARY )
endif( NOT Xerces-c_FIND_QUIETLY )



#
# Prepare the standart return
# ===========================
#
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(XERCESC DEFAULT_MSG
  XERCESC_INCLUDE_DIR XERCESC_Xerces-c_LIBRARY)
if(XERCESC_FOUND)
  set(XERCESC_INCLUDE_DIRS ${XERCESC_INCLUDE_DIR})
  set(XERCESC_LIBRARIES ${XERCESC_Xerces-c_LIBRARY} )
endif() 


# don't show the internal variables outside the advanced view
mark_as_advanced( 
  XERCESC_INCLUDE_DIR
  XERCESC_Xerces-c_LIBRARY
)
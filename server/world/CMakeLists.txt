# This file is part of COMP_hack.
#
# Copyright (C) 2010-2017 COMP_hack Team <compomega@tutanota.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

PROJECT(comp_world)

MESSAGE("** Configuring ${PROJECT_NAME} **")

# Add a target to generate API documentation.
FILE(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/api/server/world)
GENERATE_DOCS(doc/Doxyfile.in)

# Add a directory to put the objgen output into.
FILE(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/objgen)

SET(${PROJECT_NAME}_SRCS
    src/AccountManager.cpp
    src/CharacterManager.cpp
    src/ManagerConnection.cpp
    src/WorldServer.cpp
    src/WorldSyncManager.cpp
    src/main.cpp
)

SET(${PROJECT_NAME}_HDRS
    src/AccountManager.h
    src/CharacterManager.h
    src/ManagerConnection.h
    src/WorldServer.h
    src/WorldSyncManager.h
)

SET(${PROJECT_NAME}_SCHEMA
    schema/worldconfig.xml
)

SOURCE_GROUP("objgen" ${CMAKE_CURRENT_BINARY_DIR}/objgen/*)

OBJGEN_XML(${PROJECT_NAME}_STRUCTS
    # Main schema
    schema/master.xml

    # Included schemas
    ${${PROJECT_NAME}_SCHEMA}

    # Include paths
    schema
    ../../libcomp/schema

    # Output files
    WorldConfig.h
    WorldConfig.cpp
)

SOURCE_GROUP("Source Files\\Packets" src/packets/*)

SET(${PROJECT_NAME}_PACKETS
    src/packets/GetWorldInfo.cpp               # 0x1001
    src/packets/SetChannelInfo.cpp             # 0x1003
    src/packets/AccountLogin.cpp               # 0x1004
    src/packets/AccountLogout.cpp              # 0x1005
    src/packets/Relay.cpp                      # 0x1006
    src/packets/DataSync.cpp                   # 0x1007
    src/packets/CharacterLogin.cpp             # 0x1008
    src/packets/FriendsUpdate.cpp              # 0x1009
    src/packets/PartyUpdate.cpp                # 0x100A
    src/packets/ClanUpdate.cpp                 # 0x100B
)

IF(SINGLE_SOURCE_PACKETS)
    COMBINE_PACKETS(${PROJECT_NAME}_PACKETS)
ENDIF(SINGLE_SOURCE_PACKETS)

COVERALLS_SOURCES(
    ${${PROJECT_NAME}_SRCS}
    ${${PROJECT_NAME}_PACKETS}
)

ADD_EXECUTABLE(${PROJECT_NAME} ${${PROJECT_NAME}_SRCS}
    ${${PROJECT_NAME}_HDRS} ${${PROJECT_NAME}_PACKETS}
    ${${PROJECT_NAME}_STRUCTS})

ADD_DEPENDENCIES(${PROJECT_NAME} asio)

SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES FOLDER "Server")

TARGET_INCLUDE_DIRECTORIES(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/objgen
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)

TARGET_LINK_LIBRARIES(${PROJECT_NAME} ${CMAKE_THREAD_LIBS_INIT} comp tinyxml2
    civetweb-cxx civetweb)

IF(USE_COTIRE)
    cotire(${PROJECT_NAME})
ENDIF(USE_COTIRE)

UPX_WRAP(${PROJECT_NAME})

INSTALL(TARGETS ${PROJECT_NAME} DESTINATION ${COMP_INSTALL_DIR})

# Include the PDB file if on Windows
IF(WIN32)
    INSTALL(FILES $<TARGET_PDB_FILE:${PROJECT_NAME}> DESTINATION ${COMP_INSTALL_DIR})
ENDIF(WIN32)

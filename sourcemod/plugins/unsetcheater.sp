#include <sourcemod>

#define PLUGIN_VERSION 1.0.0

#pragma newdecls required
#pragma semicolon 1

public Plugin myinfo = 
{
	name = "Unset Cheater (GOKZ)", 
	author = "Dave", 
	description = "Unsets G-Banned Players as cheaters (GOKZ)", 
	version = PLUGIN_VERSION, 
	url = "https://github.com/devdaveid/"
};

public void OnClientConnected(int client)
{
    char buffer[64];

    GetClientAuthId(client, AuthId_Steam2, buffer, sizeof(buffer));

    ServerCommand("sm_setnotcheater %s", buffer);
}

#include <sourcemod>

#define PLUGIN_VERSION "1.1.0"

#pragma newdecls required
#pragma semicolon 1

public Plugin myinfo = 
{
	name = "Unset Cheater (GOKZ)", 
	author = "Dave", 
	description = "Unsets G-Banned Players as cheaters (GOKZ)", 
	version = PLUGIN_VERSION, 
	url = "https://github.com/devdaveid"
};

public void OnClientPostAdminCheck(int client)
{
    char buffer[64];

    if(!IsFakeClient(client) && IsClientInGame(client))
    {
        if(GetClientAuthId(client, AuthId_Steam2, buffer, sizeof(buffer)))
        {
            LogMessage("%s", buffer);
            ParsePlayers(client, buffer); 
        }
    
    }
}

void ParsePlayers(int client, char steamid[64]) {
    char path[PLATFORM_MAX_PATH];
    BuildPath(Path_SM, path, sizeof(path), "configs/unsetcheaters.cfg");

    if(!FileExists(path)) {
        ServerCommand("sm_setnotcheater %s", steamid);

        LogMessage("CFG file %s is not found", path);
        return;
	}

    File sFile = OpenFile(path, "r");

    if(sFile == null) {
        ServerCommand("sm_setnotcheater %s", steamid);

        LogMessage("Could not open file at path %s", path);
        return;
    }

    char buffer[64];

    while(!IsEndOfFile(sFile)) {
        ReadFileLine(sFile, buffer, sizeof(buffer));



        if(StrEqual(buffer, steamid))
        {
            CloseHandle(sFile);

            ServerCommand("sm_setnotcheater %s", steamid);
            return;
        }
    }

    CloseHandle(sFile);
    return;
}

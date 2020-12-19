#include sourcemod
#include warden

#pragma semicolon 1
#pragma newdecls required

bool godalcam = false;

#define CT          3

public Plugin myinfo = 
{
	name = "...", 
	author = "phiso", 
	description = "...", 
	version = "1.0", 
	url = "phiso#3331"
};

public void OnPluginStart()
{
	HookEvent("round_start", godkontrol);
	RegConsoleCmd("sm_godalcam", Godalcm);
} 

public Action Godalcm(int client, int args)
{
	if (warden_iswarden(client))
	{
		godalcam = true;
		PrintToChatAll("[SM] \x0BKomutçu \x04Diğer elin \x02god \x04olmasını istedi!", client);
	}
}

public Action godkontrol(Event event, const char[] name, bool dontBroadcast)
{
	if (godalcam)
	{
		Handle hHudText = CreateHudSynchronizer();
		SetHudTextParams(-1.0, -0.5, 5.0, 255, 0, 0, 255, 2, 1.0, 0.1, 0.2);
		for (int i = 1; i <= MaxClients; i++)
		{
			if (!IsFakeClient(i) && IsClientInGame(i))
			{
				ShowSyncHudText(i, hHudText, "! BU EL GODLU !");
				PrintToChat(i, "[SM] \x02Komutçuya ve korumaya otomatik olarak god verildi.");
			}
			if (GetClientTeam(i) == CT && !IsFakeClient(i) && IsClientInGame(i))
			{
				SetEntProp(i, Prop_Data, "m_takedamage", 0, 1);
			}
		}
		godalcam = false;
	}
} 
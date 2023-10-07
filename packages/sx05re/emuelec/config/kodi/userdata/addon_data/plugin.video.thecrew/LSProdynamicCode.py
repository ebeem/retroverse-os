#$pyFunction
def GetLSProData(page_data,Cookie_Jar,m,url = ''):
    from resources.lib.modules import client
    import xbmc,xbmcgui
    pDialog = xbmcgui.DialogProgress()
    pDialog.create('[B][COLOR orchid]THE CREW SPORTS[/COLOR][/B]', 'The Crew Is Loading Your Event Please Wait....')
    url = client.external('https://1stream.soccer/soccer/whickham-carlisle-city-live-stream/1164025')
    pDialog.update(65,'The Crew Is Loading Your Event Please Wait....')
    pDialog.close()
    if (pDialog.iscanceled()): return
    return url
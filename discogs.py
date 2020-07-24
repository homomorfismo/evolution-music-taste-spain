import discogs_client
import pandas as pd
from tqdm import tqdm
import time

# initialize the API
# create an account in Discogs and after create an app
# user_token can be obtained here https://www.discogs.com/es/settings/developers
discogs = discogs_client.Client('loscuarentaprincipales', user_token='IyGfZENKyjOxCigqSiMAGfHlUkOHwvkctfPEWcJj')

playlists = pd.read_csv('playlists.csv')
playlists = playlists.drop(playlists.columns[0], axis=1)
playlists.fillna(value='', inplace=True)
uniques = playlists[['Song', 'Artist']].drop_duplicates()
uniques = uniques.reset_index(drop=True)
n = len(uniques)
for i in tqdm(range(739,n)):
    song, artist = uniques.loc[i]
    results = discogs.search(song + ', ' + artist, type='release')
    if len(results)>0:
        genre = results[0].genres if results[0].genres is not None else []
        styles = results[0].styles if results[0].styles is not None else []
        genres = list(set().union(genre, styles))
    else:
        genres = []
    playlists.loc[playlists["Song"] == song, 'Genre'] = ', '.join(genres) if len(genres) > 0 else 'unknown'
    time.sleep(1.5)
playlists.to_csv('playlists2.csv')

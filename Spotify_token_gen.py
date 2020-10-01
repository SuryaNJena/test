#Spotify Access token generation for Client Credentials Flow
client_id = 'abc123'      # client_id
client_secret = '123xyz'  # client_secret
to_encode = client_id + ':' + client_secret
base64_encoded_id_secret = base64.b64encode(to_encode.encode()).decode()
headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Basic {}'.format(base64_encoded_id_secret)
    }
params = {'grant_type': 'client_credentials'}
r = requests.post('https://accounts.spotify.com/api/token', headers=headers, params=params)
token = r.json()['access_token']

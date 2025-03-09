const expoAccessToken = Deno.env.get('EXPO_ACCESS_TOKEN')

if (!expoAccessToken) {
  throw new Error('Missing environment variables: EXPO_ACCESS_TOKEN')
}

export default expoAccessToken

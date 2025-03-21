import { WebhookPayload } from '../types/webhookPayload.ts'
import sendMultiplePushNotifications from '../utils/sendMultiplePushNotifications.ts'
import supabase from '../utils/supabase.ts'

type Notification = {
  id: string
  player_one: string
  player_two: string
  score_one: number
  score_two: number
  status: 'in_lobby' | 'active' | 'ended'
  community: string | null
}

Deno.serve(async (req) => {
  const payload: WebhookPayload<Notification> = await req.json()

  if (payload.record.status !== 'ended' || payload.record.community === null) {
    return new Response(null, {
      headers: { 'Content-Type': 'application/json' },
      status: 304
    })
  }

  const { data: users } = await supabase
    .from('communities_users')
    .select('user')
    .eq('community', payload.record.community)

  if (!users) {
    return new Response(JSON.stringify({ error: 'Cannot find community' }), {
      headers: { 'Content-Type': 'application/json' },
      status: 500
    })
  }

  const { data: playerOne } = await supabase
    .from('users')
    .select('name')
    .eq('id', payload.record.player_one)
    .single<{ name: string }>()

  if (!playerOne) {
    return new Response(JSON.stringify({ error: 'Cannot find player one' }), {
      headers: { 'Content-Type': 'application/json' },
      status: 500
    })
  }

  const { data: playerTwo } = await supabase
    .from('users')
    .select('name')
    .eq('id', payload.record.player_two)
    .single<{ name: string }>()

  if (!playerTwo) {
    return new Response(JSON.stringify({ error: 'Cannot find player two' }), {
      headers: { 'Content-Type': 'application/json' },
      status: 500
    })
  }

  const { data: community } = await supabase
    .from('communities')
    .select('name')
    .eq('id', payload.record.community)
    .single<{ name: string }>()

  if (!community) {
    return new Response(JSON.stringify({ error: 'Cannot find community' }), {
      headers: { 'Content-Type': 'application/json' },
      status: 500
    })
  }

  const body =
    payload.record.score_one === payload.record.score_two
      ? `The battle between ${playerOne.name} and ${playerTwo.name} resulted in a draw.`
      : payload.record.score_one > payload.record.score_two
        ? `${playerOne.name} defeated ${playerTwo.name} in the last ranked battle.`
        : `${playerTwo.name} defeated ${playerOne.name} in the last ranked battle.`

  try {
    const res = await sendMultiplePushNotifications({
      title: community.name,
      body,
      users: users.map(({ user }) => user),
      url: `game/${payload.record.id}`,
      notifications: ['communities']
    })

    return new Response(JSON.stringify(res), {
      headers: { 'Content-Type': 'application/json' }
    })
  } catch (e) {
    return new Response(JSON.stringify({ e, result: 'error' }), {
      headers: { 'Content-Type': 'application/json' },
      status: 500
    })
  }
})

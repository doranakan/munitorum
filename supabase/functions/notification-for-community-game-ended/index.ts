import { WebhookPayload } from '../types/webhookPayload.ts'
import sendPushNotification from '../utils/sendPushNotification.ts'
import supabase from '../utils/supabase.ts'

type Notification = {
  id: string
  player_one: string
  player_two: string
  score_one: number
  score_two: number
  community: string | null
}

Deno.serve(async (req) => {
  const payload: WebhookPayload<Notification> = await req.json()

  if (payload.record.community === null) {
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

  if (!user) {
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

  if (!user) {
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

  const body = score_one === score_two ? `The battle between ${playerOne.name} and ${playerTwo.name} resulted in a draw.` : score_one > score_two ? `${playerOne.name} defeated ${playerTwo.name} in the last battle.` : `${playerTwo.name} defeated ${playerOne.name} in the last battle.` 

  try {
    const res = await sendPushNotification({
      title: community.name,
      body,
      to: users,
      url: `games/${payload.record.id}`,
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

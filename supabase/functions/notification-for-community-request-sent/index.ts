import { WebhookPayload } from '../types/webhookPayload.ts'
import sendPushNotification from '../utils/sendPushNotification.ts'
import supabase from '../utils/supabase.ts'

type Notification = {
  id: string
  user: string
  community: string
  accepted: boolean | null
}

Deno.serve(async (req) => {
  const payload: WebhookPayload<Notification> = await req.json()

  if (payload.record.accepted !== null) {
    return new Response(null, {
      headers: { 'Content-Type': 'application/json' },
      status: 304
    })
  }

  const { data: user } = await supabase
    .from('users')
    .select('name')
    .eq('id', payload.record.user)
    .single<{ name: string }>()

  if (!user) {
    return new Response(JSON.stringify({ error: 'Cannot find user' }), {
      headers: { 'Content-Type': 'application/json' },
      status: 500
    })
  }

  const { data: admin } = await supabase
    .from('communities_users')
    .select('user')
    .eq('role', 'admin')
    .eq('community', payload.record.community)
    .single<{ user: string }>()

  if (!admin) {
    return new Response(
      JSON.stringify({ error: 'Selected community has no admin' }),
      {
        headers: { 'Content-Type': 'application/json' },
        status: 500
      }
    )
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

  try {
    const res = await sendPushNotification({
      title: community.name,
      body: `${user.name} wants to join the community`,
      user: admin.user,
      url: `communities/${payload.record.community}`,
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

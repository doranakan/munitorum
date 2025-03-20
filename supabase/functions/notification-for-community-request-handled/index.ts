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

  if (payload.record.accepted === null) {
    return new Response(null, {
      headers: { 'Content-Type': 'application/json' },
      status: 304
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

  try {
    const res = await sendPushNotification({
      title: community.name,
      body: `Your request has been ${payload.record.accepted ? 'accepted 🎉' : 'denied 🚫'}`,
      user: payload.record.user,
      url: `communities-tab`,
      notifications: ['communities']
    })

    return new Response(JSON.stringify({ res, result: 'success' }), {
      headers: { 'Content-Type': 'application/json' }
    })
  } catch (e) {
    return new Response(JSON.stringify({ e, result: 'error' }), {
      headers: { 'Content-Type': 'application/json' },
      status: 500
    })
  }
})

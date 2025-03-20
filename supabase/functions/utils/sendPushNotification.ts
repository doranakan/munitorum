import expoAccessToken from './expoAccessToken.ts'
import supabase from './supabase.ts'

type Args = {
  title: string
  body: string
  user: string
  notifications: string[]

  url?: string
}

const sendPushNotification = async ({
  body,
  notifications,
  title,
  user,
  url
}: Args) => {
  const { data: pushTokens } = await supabase
    .from('users_push_tokens')
    .select('push_token')
    .eq('user', user)

  const { data } = await supabase
    .from('user_notifications')
    .select('notifications')
    .eq('user', user)
    .single<{ notifications: Record<string, number> }>()

  const oldNotifications = data?.notifications ?? {}

  const newNotifications = notifications.reduce(
    (acc, curr) => ({ ...acc, [curr]: (oldNotifications[curr] ?? 0) + 1 }),
    {}
  )

  await supabase
    .from('user_notifications')
    .upsert({
      user,
      notifications: {
        ...oldNotifications,
        ...newNotifications
      }
    })
    .eq('user', user)

  const badge = oldNotifications
    ? Object.keys(oldNotifications).reduce(
        (acc, curr) => oldNotifications[curr] + acc,
        0
      )
    : 0

  const res = await fetch('https://exp.host/--/api/v2/push/send', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${expoAccessToken}`
    },
    body: JSON.stringify({
      to: pushTokens?.map(
        ({ push_token }: { push_token: string }) => push_token
      ),
      title,
      body,
      badge: badge + 1,
      sound: 'notification.wav',
      channel: 'appdeptus',
      data: {
        url
      }
    })
  }).then((res) => res.json())

  const receiptIds = res.data
    .map((item: { id: string }) => item.id)
    .filter(Boolean) // Filter out empty or undefined IDs

  if (receiptIds.length > 0) {
    const receiptRes = await fetch(
      'https://exp.host/--/api/v2/push/getReceipts',
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${expoAccessToken}`
        },
        body: JSON.stringify({
          ids: receiptIds
        })
      }
    )

    return await receiptRes.json()
  }

  return res
}

export default sendPushNotification

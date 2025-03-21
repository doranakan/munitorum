import expoAccessToken from './expoAccessToken.ts'
import supabase from './supabase.ts'

type Args = {
  title: string
  body: string
  users: string[]
  notifications: string[]
  url?: string
}

const sendMultiplePushNotifications = async ({
  body,
  notifications,
  title,
  users,
  url
}: Args) => {
  const { data: pushTokens } = await supabase
    .from('users_push_tokens')
    .select('user, push_token')
    .in('user', users)

  const { data: notificationsData } = await supabase
    .from('user_notifications')
    .select('user, notifications')
    .in('user', users)

  const notificationsMap = Object.fromEntries(
    (notificationsData || []).map(({ user, notifications }) => [
      user,
      notifications
    ])
  )

  const updates = users.map((user) => {
    const oldNotifications = notificationsMap[user] || {}
    const newNotifications = notifications.reduce(
      (acc, curr) => ({ ...acc, [curr]: (oldNotifications[curr] ?? 0) + 1 }),
      {}
    )

    return {
      user,
      notifications: { ...oldNotifications, ...newNotifications }
    }
  })

  await supabase.from('user_notifications').upsert(updates)

  const badgeCounts = Object.fromEntries(
    updates.map(({ user, notifications }) => [
      user,
      Object.values(notifications).reduce(
        (acc: number, curr) => acc + Number(curr),
        0
      )
    ])
  )

  const pushMessages = (pushTokens || []).map(({ user, push_token }) => ({
    to: push_token,
    title,
    body,
    badge: (badgeCounts[user] ?? 0) + 1,
    sound: 'notification.wav',
    channel: 'appdeptus',
    data: { url }
  }))

  if (!pushMessages || pushMessages.length === 0) return

  const res = await fetch('https://exp.host/--/api/v2/push/send', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${expoAccessToken}`
    },
    body: JSON.stringify(pushMessages)
  }).then((res) => res.json())

  const receiptIds = res.data
    .map((item: { id: string }) => item.id)
    .filter(Boolean)

  if (receiptIds.length > 0) {
    const receiptRes = await fetch(
      'https://exp.host/--/api/v2/push/getReceipts',
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${expoAccessToken}`
        },
        body: JSON.stringify({ ids: receiptIds })
      }
    )

    return await receiptRes.json()
  }

  return res
}

export default sendMultiplePushNotifications

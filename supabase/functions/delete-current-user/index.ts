// Follow these steps to run the function in a secure environment.
// 1. Ensure Supabase secrets (SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY) are set in your environment.

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.47.12'

const supabaseUrl = Deno.env.get('SUPABASE_URL')
const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')

if (!supabaseUrl || !serviceRoleKey) {
  throw new Error(
    'Missing environment variables: SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY'
  )
}

const supabaseAdmin = createClient(supabaseUrl, serviceRoleKey)

serve(async (req) => {
  try {
    // Parse the authorization header to get the user's JWT
    const authHeader = req.headers.get('Authorization')
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401
      })
    }

    const jwt = authHeader.split(' ')[1]

    // Validate the JWT and retrieve the user's ID
    const {
      data: { user },
      error
    } = await supabaseAdmin.auth.getUser(jwt)

    if (error || !user) {
      return new Response(
        JSON.stringify({ error: 'Invalid or expired token' }),
        { status: 401 }
      )
    }

    const userId = user.id

    // Delete the user from Supabase Auth
    const { error: deleteError } =
      await supabaseAdmin.auth.admin.deleteUser(userId)

    if (deleteError) {
      console.error('Error deleting user:', deleteError)
      return new Response(JSON.stringify({ error: 'Error deleting user' }), {
        status: 500
      })
    }

    return new Response(
      JSON.stringify({ message: 'User deleted successfully' }),
      { status: 200 }
    )
  } catch (err) {
    console.error('Unexpected error:', err)
    return new Response(
      JSON.stringify({ error: 'Unexpected error occurred' }),
      { status: 500 }
    )
  }
})

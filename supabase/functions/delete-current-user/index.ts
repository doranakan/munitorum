import supabase from '../utils/supabase.ts'

Deno.serve(async (req) => {
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
    } = await supabase.auth.getUser(jwt)

    if (error || !user) {
      return new Response(
        JSON.stringify({ error: 'Invalid or expired token' }),
        { status: 401 }
      )
    }

    const userId = user.id

    // Delete the user from Supabase Auth
    const { error: deleteError } = await supabase.auth.admin.deleteUser(userId)

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

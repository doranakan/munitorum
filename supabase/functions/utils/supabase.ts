import { createClient } from 'jsr:@supabase/supabase-js@2'

const supabaseUrl = Deno.env.get('SUPABASE_URL')
const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')
if (!supabaseUrl || !serviceRoleKey) {
  throw new Error(
    'Missing environment variables: SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY'
  )
}
const supabase = createClient(supabaseUrl, serviceRoleKey)

export default supabase

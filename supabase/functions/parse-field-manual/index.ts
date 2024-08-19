import { Buffer } from 'node:buffer'
import PDF from 'npm:pdf-parse/lib/pdf-parse.js'

Deno.serve(async (req) => {
  const body = (await req.body?.getReader().read())?.value

  if (body) {
    const dataBuffer = Buffer.from(body)

    console.log({ dataBuffer })

    const pdf = await PDF(dataBuffer)

    return new Response(JSON.stringify(pdf), {
      headers: { 'Content-Type': 'application/json' }
    })
  }

  return new Response('OK', {
    headers: { 'Content-Type': 'application/json' }
  })
})

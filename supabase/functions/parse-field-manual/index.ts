import { multiParser } from 'https://deno.land/x/multiparser@0.114.0/mod.ts'
import { Buffer } from 'node:buffer'
import { createClient } from 'npm:@supabase/supabase-js'
import PDF from 'npm:pdf-parse/lib/pdf-parse.js'

const supabaseUrl = 'https://loiaudkefvrskuizrfip.supabase.co'
const supabaseKey =
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxvaWF1ZGtlZnZyc2t1aXpyZmlwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk2MDEyNDUsImV4cCI6MjAzNTE3NzI0NX0.l6bQsL09kUCaStEwFccO3VBP1niobBqiZSaDSJiqPZw'
const supabase = createClient(supabaseUrl, supabaseKey)

type Faction = {
  codex: string
  units: {
    name: string
    tiers: {
      models: number
      points: number
    }[]
    upgrades: {
      name: string
      points: number
    }[]
  }[]
  detachments: {
    name: string
    enhancements: {
      name: string
      points: number
    }[]
  }[]
}

Deno.serve(async (req) => {
  const form = await multiParser(req)

  if (form && 'content' in form.files.manual) {
    const dataBuffer = Buffer.from(form.files.manual.content)

    try {
      const pdf = await PDF(dataBuffer)

      const manual = (pdf.text as string).split('\n')

      let faction: Faction = { codex: '', units: [], detachments: [] }

      let ignoreUnits = false
      let unitName = ''
      let multilineName = ''

      let isDet = false
      let detName = ''

      const parsedManual = manual
        .reduce((acc: Faction[], curr: string, index) => {
          const value = curr.trim()

          if (value.length > 3) {
            if (value.includes('CODEX') || value.includes('INDEX')) {
              ignoreUnits = false
              isDet = false

              const factionToAdd = { ...faction }

              faction = { codex: '', units: [], detachments: [] }
              if (value.includes('CODEX')) {
                faction.codex = parseCodexName(value.replace('CODEX: ', ''))
              }
              if (value.includes('INDEX')) {
                faction.codex = parseCodexName(value.replace('INDEX: ', ''))
              }
              return [...acc, factionToAdd]
            }

            if (value === 'FORGE WORLD POINTS VALUES') {
              ignoreUnits = true
              return acc
            }

            if (value === 'EVERY MODEL HAS') {
              isDet = false
              ignoreUnits = true
              return acc
            }
            //DETACHMENTS
            if (value === 'DETACHMENT ENHANCEMENTS') {
              isDet = true
              return acc
            }
            if (isDet) {
              if (value.endsWith('pts')) {
                faction = {
                  ...faction,
                  detachments: faction.detachments.map((det) => {
                    if (det.name !== detName) {
                      return det
                    }

                    const name = value.split('.')[0]?.trim() ?? ''

                    const points = value.split('.').reduce((_, c) => {
                      if (c.includes('pts')) {
                        const p = c.split(' ')[0]

                        if (!isNaN(Number(p))) {
                          return Number(p)
                        }

                        return 0
                      }
                      return 0
                    }, 0)

                    return {
                      ...det,
                      enhancements: [
                        ...(det.enhancements ?? []),
                        {
                          name,
                          points
                        }
                      ]
                    }
                  })
                }
                return acc
              }

              detName = value

              faction = {
                ...faction,
                detachments: [
                  ...faction.detachments,
                  { name: value, enhancements: [] }
                ]
              }

              return acc
            }

            //UPGRADES
            if (!ignoreUnits && value.endsWith('pts') && value.includes('+')) {
              faction = {
                ...faction,
                units: faction.units.map((unit) => {
                  if (unit.name !== unitName) {
                    return unit
                  }

                  const name = value.split('.')[0]?.trim() ?? ''

                  const points = value.split('.').reduce((_, c) => {
                    if (c.includes('pts')) {
                      const p = c.split(' ')[0]

                      if (!isNaN(Number(p))) {
                        return Number(p)
                      }

                      return 0
                    }
                    return 0
                  }, 0)

                  return {
                    ...unit,
                    upgrades: [
                      ...(unit.upgrades ?? []),
                      {
                        name,
                        points
                      }
                    ]
                  }
                })
              }

              return acc
            }

            //MULTILINE NAME
            if (value.includes(',')) {
              multilineName = value

              return acc
            }

            //TIERS
            if (!ignoreUnits && value.endsWith('pts') && !value.includes('+')) {
              faction = {
                ...faction,
                units: faction.units.map((unit) => {
                  if (unit.name !== unitName) {
                    return unit
                  }

                  let models = 0
                  let points = 0

                  if (value.includes('model')) {
                    const quantity = value.split('model')[0]

                    if (!isNaN(Number(quantity.trim()))) {
                      models = Number(quantity.trim())
                    }
                  }

                  if (value.includes('and')) {
                    models =
                      `${multilineName}${value}`
                        .split('.')[0]
                        ?.split(' ')
                        .reduce((a, c) => {
                          if (!isNaN(Number(c))) {
                            return (a += Number(c))
                          }
                          return a
                        }, 0) ?? 0
                    multilineName = ''
                  }

                  if (value.includes('-')) {
                    const m = value
                      .split('.')[0]
                      ?.split('-')[1]
                      ?.split('model')[0]
                      ?.trim()

                    if (m && !isNaN(Number(m))) {
                      models = Number(m)
                    }
                  }

                  points = value.split('.').reduce((_, c) => {
                    if (c.includes('pts')) {
                      const p = c.split(' ')[0]

                      if (!isNaN(Number(p))) {
                        return Number(p)
                      }

                      return 0
                    }
                    return 0
                  }, 0)

                  return {
                    ...unit,
                    tiers: [...(unit.tiers ?? []), { models, points }]
                  }
                })
              }

              return acc
            }

            //UNITS
            if (!ignoreUnits && faction.codex.length) {
              unitName = value

              faction = {
                ...faction,
                units: [
                  ...faction.units.filter(({ tiers }) => tiers.length > 0),
                  { name: value, tiers: [], upgrades: [] }
                ]
              }

              return acc
            }
            return acc
          }

          if (manual.length - 1 === index) {
            return [...acc, faction]
          }
          return acc
        }, [])
        .filter(({ units }) => units.length)

      await supabase.auth.signInWithPassword({
        email: 'doranakan@appdeptus.com',
        password: '1313'
      })

      for (const entry of parsedManual) {
        const { data } = await supabase
          .from('codexes')
          .upsert({ name: entry.codex })
          .select()

        const codexId = (data as { id: string }[])[0]?.id

        if (codexId) {
          for (const unit of entry.units) {
            const { data } = await supabase
              .from('units')
              .upsert({ name: unit.name, codex: codexId })
              .select()

            const unitId = (data as { id: string }[])[0]?.id

            if (unitId) {
              for (const tier of unit.tiers) {
                await supabase
                  .from('unit_tiers')
                  .upsert({ ...tier, unit: unitId })
              }
              for (const upgrade of unit.upgrades) {
                await supabase
                  .from('unit_upgrades')
                  .upsert({ ...upgrade, unit: unitId })
              }
            }
          }
          for (const detachment of entry.detachments) {
            const { data } = await supabase
              .from('detachments')
              .upsert({ name: detachment.name, codex: codexId })
              .select()

            const detachmentId = (data as { id: string }[])[0]?.id

            if (detachmentId) {
              for (const enhancement of detachment.enhancements) {
                await supabase
                  .from('detachment_enhancements')
                  .upsert({ ...enhancement, detachment: detachmentId })
              }
            }
          }
        }
      }

      return new Response(JSON.stringify(parsedManual), {
        headers: { 'Content-Type': 'application/json' }
      })
    } catch (e) {
      console.log({ e })
    }
  }

  return new Response('OK', {
    headers: { 'Content-Type': 'application/json' }
  })
})

const parseCodexName = (value: string): string =>
  value
    .replace('’', "'")
    .toLowerCase()
    .split(' ')
    .reduce((acc, curr, index) => {
      const capitalized = curr.split('').reduce((a, c, i) => {
        if (!i) {
          return c.toUpperCase()
        }
        return `${a}${c}`
      }, '')
      if (!index) {
        return capitalized
      }
      return `${acc} ${capitalized}`
    }, '')

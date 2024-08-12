# Munitorum

Munitorum is the [Supabase](https://supabase.com/)-powered Appdeptus backend.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/)
- [Supabase CLI](https://supabase.com/docs/guides/cli)

### Setup

1. Clone the repo and install dependencies:

   ```bash
   git clone https://github.com/yourusername/munitorum.git
   cd munitorum
   npm install
   ```

2. Configure the environment:

   ```bash
   cp .env.example .env
   supabase db up
   ```

3. Run the edge functions server:

   ```bash
   supabase start
   supabase functions serve
   ```

## License

[MIT](LICENSE)

---

This version keeps it straight to the point while covering the essentials.

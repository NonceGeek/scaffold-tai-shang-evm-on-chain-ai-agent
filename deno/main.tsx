/* 
the api for ai dimsum devs.
*/
// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.
import { Application, Router } from "oak";
import { oakCors } from "cors";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

console.log("Hello from AI Agent Generator API!");

const router = new Router();

router
.get("/", async (context) => {
  context.response.body = { result: "Hello, Devs from AI Agent Generator API!" };
})
.get("/ai_agents", async (context) => {

  const supabase = createClient(
  // Supabase API URL - env var exported by default.
  Deno.env.get('SUPABASE_URL') ?? '',
  // Supabase API ANON KEY - env var exported by default.
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
    // Create client with Auth context of the user that called the function.
    // This way your row-level-security (RLS) policies are applied.
    // { global: { headers: { Authorization: req.headers.get('Authorization')! } } }
  )
  // 1. create a item in bodhi_user_search.
  const { data, error } = await supabase.
    from('bodhi_based_evm_ai_agents')
    .select();
  context.response.body = data
});

const app = new Application();

app.use(oakCors()); // Enable CORS for All Routes
app.use(router.routes());

console.info("CORS-enabled web server listening on port 8000");
await app.listen({ port: 8000 });

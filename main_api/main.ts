import { whoami_handler } from "./core/whoami_handler.ts";

Deno.serve((req) => {
  if (new URL(req.url).pathname === "/") {
    return whoami_handler(req);
  }

  return new Response("Not found", { status: 404 });
});

import { hello_world_handler } from "./core/hello_world_handler.ts";

Deno.serve((req) => {
  if (new URL(req.url).pathname === "/") {
    return hello_world_handler();
  }

  return new Response("Not found", { status: 404 });
});

import { whoami_handler } from "./lib/api/whoami_handler.ts";

const html = String.raw;
const page = html`
  <button id="whoami">Who am I?</button>
  <script>
  const btn = document.getElementById("whoami");
  btn.onclick = async () => {
    const res = await fetch("/api/whoami");
    const jData = await res.json();

    alert(jData || "You are not registered yet!");
  }
  </script>
`;

Deno.serve(async (req) => {
  const url = new URL(req.url);

  if (url.pathname === "/api/whoami") {
    return await whoami_handler(req);
  }

  return new Response(page, {
    headers: {
      "content-type": "text/html",
    },
  });
});

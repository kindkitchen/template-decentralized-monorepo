import { ApolloServer } from "@apollo/server";
import { ApolloServerPluginLandingPageLocalDefault } from "@apollo/server/plugin/landingPage/default";
import typeDefs from "./core/schema.gql" with { type: "text" };
// @ts-types="@as-integrations/cloudflare-workers/src/index.ts"
import {
  startServerAndCreateCloudflareWorkersHandler,
} from "@as-integrations/cloudflare-workers";
import { GqlApiCtx } from "./core/GqlApiCtx.ts";

const apollo = new ApolloServer<GqlApiCtx>({
  typeDefs,
  resolvers: {},
  introspection: true,
  plugins: [
    ApolloServerPluginLandingPageLocalDefault(),
  ],
});
const gql_handler = startServerAndCreateCloudflareWorkersHandler(
  apollo,
  {
    context: async ({ request: _req, env: _env, ctx }) => {
      await Promise.resolve(
        "TODO: use this context integration in proper and effective way",
      );

      return ctx; /// suppose the caller will pass required context directly
    },
  },
);

Deno
  .serve(
    {
      port: +(Deno.env.get("PORT") || 3000),
    },
    (req) => {
      const url = new URL(req.url);

      if (url.pathname === "/graphql") {
        return gql_handler(
          req,
          {},
          {
            req,
            url,
          } satisfies GqlApiCtx,
        );
      }

      return new Response("hello world");
    },
  );

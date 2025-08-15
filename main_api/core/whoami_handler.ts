import { User } from "../lib/domain/User.ts";

export const whoami_handler = async (_req: Request): Promise<Response> => {
  const data: User | null = null;

  return await Promise.resolve(
    new Response(data && JSON.parse(data), {
      headers: {
        "content-type": "application/json",
      },
    }),
  );
};

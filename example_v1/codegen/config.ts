import type { CodegenConfig } from "@graphql-codegen/cli";

const config: CodegenConfig = {
  schema: ["./**/*.gql"],
  generates: {
    "./codegen/out_type_defs.ts": {
      plugins: ["typescript", "typescript-operations", "typescript-resolvers"],
      config: {
        contextType: "./core/codegen/GqlApiCtx.ts#GqlApiCtx",
        mappers: {},
        enumPrefix: true,
        enumsAsTypes: true,
        showUnusedMappers: true,
      },
    },
    "./codegen/schema.gql": {
      plugins: ["schema-ast"],
      config: {
        includeDirectives: true,
      },
    },
  },
  emitLegacyCommonJSImports: false,
};
export default config;

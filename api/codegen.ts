import type { CodegenConfig } from "@graphql-codegen/cli";

const config: CodegenConfig = {
  schema: ["./**/*.gql"],
  generates: {
    "./core/out_type_defs.ts": {
      plugins: ["typescript", "typescript-operations", "typescript-resolvers"],
      config: {
        contextType:
          /**
           * This is not exactly the path to type, rather the instruction how to generate the "import line" in the files
           * So in our case we assume that generated stuff will be in <core> folder and so because
           * this type will be placed also here - that is why it is simply started with "./" => counting from the
           * directory, where generated file is existed
           */
          "./GqlApiCtx.ts#GqlApiCtx",
        enumPrefix: true,
        enumsAsTypes: true,
        showUnusedMappers: true,
      },
    },
    "./core/schema.gql": {
      plugins: ["schema-ast"],
      config: {
        includeDirectives: true,
      },
    },
  },
  emitLegacyCommonJSImports: false,
};
export default config;

## 🚨 ARCHIVED: This repository is no longer maintained 🚨

#### It's upgraded and rethink version is developed here - [https://github.com/kindkitchen/froot.git](https://github.com/kindkitchen/froot.git)

### [Froot](https://github.com/kindkitchen/froot.git)

> This project is now archived. A new, updated version—incorporating all the best ideas from this codebase—will be released soon. Stay tuned for the next evolution!

# Template Decentralized Monorepo

> **Note:** This repository is now archived. For future updates, watch this space for the announcement of the new version.

---

# About

Main idea - to be able work on any member of monorepo as it was it's root. Such possibility simplify a lot of tool's integration processes, workflow and also helps to see the project from specific perspective.

## ⚡️ Just Integration & Project Automation

This project uses [just](https://github.com/casey/just) as a powerful task runner and project automation tool. All key workflows are defined as scripts in the `.just` folder and orchestrated via the main `JUSTFILE` at the root.

### Highlights

- **Modular Task Scripts:** Each `.just/*.just` file encapsulates a specific workflow (testing, versioning, linking, docs, etc.), making automation easy to extend and maintain.
- **Unified Entry Point:** The `JUSTFILE` imports all scripts and exposes a unified CLI for all project operations.
- **App/Lib Linking:** Use `just app_lib_link` and `just app_lib_unlink` to symlink or unlink shared libraries between members, supporting modular development.
- **Testing:** Run `just test` to execute all Deno tests, with pattern matching support.
- **Version Management:** `just version` reads the current version from `VERSION.md`. `just bump` updates the version across all relevant package files.
- **Documentation Aggregation:** `just llm` collects all Markdown docs into a single file for LLM or Copilot use. `just copilot` updates Copilot context.

- **Git Shortcuts:** `just commit` and `just pr` automate common git flows, including submodule handling and PR creation.
- **Submodule Management:** `just pull_all_submodules` updates all git submodules recursively.
- **Helpers:** Logging and info utilities for consistent output in custom tasks.

#### Example: List All Tasks

```sh
just --list
```

#### Example: Link a Library to an App

```sh
just app_lib_link my-app util_xstate
```

#### Example: Run All Tests

```sh
just test
```

#### Example: Aggregate Markdown Docs

```sh
just llm
```

For more, see comments in each `.just/*.just` file and the `JUSTFILE`.

## Overview

This monorepo provides a template for decentralized, modular TypeScript/JavaScript projects, with a focus on:

- **Separation of concerns** via clear package boundaries
- **Reusable utilities** for state management, code generation, and project support
- **Opinionated code-generation** for xstate-based state machines
- **Documentation-driven development** with Markdown-powered helpers

---

## Key Packages & Features

### `project_support`

- Tools for aggregating and processing Markdown documentation
- Example: Recursively collect all markdown content from a root directory into a single file

### `util_xstate`

- Helpers and abstractions for integrating [xstate](https://xstate.js.org/) with [effect](https://effect.website/)
- TypeScript utilities for safe, convention-driven state machine logic
- Patterns for handling success/failure flows with `Either` types

### `util_plopper`

- Code generators for opinionated xstate machine declarations
- CLI tools and templates for reducing boilerplate and improving state-chart visualization
- "Twicert" code-generation: intermediate files for extensibility and customization

---

## Example Usage

```ts
import { promise_logic_from_effect } from "util_xstate/src/lib/promise_logic_from_effect.ts";
import { Effect, Either, Layer } from "effect";

const machine = setup({
  actors: {
    example: promise_logic_from_effect((x: number) =>
      Effect.gen(function* () {
        if (x < 0.1) throw new Error("Boom!");
        else if (x < 0.5) yield* Effect.fail("Oops...");
        return "Ok";
      }),
    ),
  },
}).createMachine({
  initial: "Start",
  states: {
    Finish: { type: "final" },
    Start: {
      invoke: {
        src: "example",
        input: { args: [Math.random()], layer: Layer.empty },
        onDone: {
          target: "Finish",
          actions: ({ event }: any) => {
            if (Either.isRight(event.output)) {
              console.info("Success:", event.output.right);
            } else {
              console.warn("Fail:", event.output.left);
            }
          },
        },
        onError: {
          target: "Finish",
          actions: ({ event }: any) => {
            console.error("Panic:", event.error);
          },
        },
      },
    },
  },
});
```

---

## Philosophy

- **Documentation as code**: Many helpers are documented in Markdown, encouraging a doc-driven workflow.
- **Extensibility**: Intermediate files and codegen patterns allow for easy extension and customization.
- **Type safety**: TypeScript-first utilities and helpers for robust, predictable code.

---

## Getting Started

1. Clone the repository
2. Explore the `project_support`, `util_xstate`, and `util_plopper` packages
3. Read the Markdown docs in each package for usage patterns and conventions

---

## License

MIT

# About

This is simple and straightforward aka monorepo/workspace solution.

### What it is different from popular solutions?

Technically it is pretty different thing I suppose. Because the main mechanism
is focused on utilizing justfile scripts, linking directories and **dynamically
switching the root of the project**.

So the main idea to not have a `monorepo` with many apps, libs etc.. But have
**single `app`** opened at current time.

### Benefits:

1. It is very simple! _Though it may looked opposite, but it is only because the
   whole logic is written directly here, any magic until you have some
   experience with bash and so on. You can simple extend, modify any part of
   this configuration. Be free to make issues, pull request!_
2. This approach try to avoid any possible problems related to monorepos because
   it is change self instead of adopting codebase. _For example some frameworks
   can have pretty strict opinionative about how and where they should be placed
   and not be friendly to monorepos. But this solution will simply change
   directory and it will looked like the app is normal mode_

## Some details:

The current folder (`ROOT`) is not for writing code but for defining your apps,
libs only.

- `ROOT` project directory _(is the directory where this readme file is placed)_
- `just home ...` _with execute any command from the root directory__
- `just home cd` _will open in vscode project directory (`ROOT`)_
- `just <your app> ...` / `just <your app> cd` have the same logic but related
  to `<your app>`
- explore example apps for more details
- try to write most code in `app/core/*` directory
- then you will be able to import it in some another app under the
  `<exported app>/*`
- again, explore dependencies between example apps

# Example:

> _(explain one, that is present in template)_

So we have such folder structure:

```
.
├── example_codegen
│   ├── core
│   │   └── Query.gql
│   ├── deno.json
│   ├── justfile
│   └── main.ts
├── example_v1
│   ├── codegen
│   │   ├── config.ts
│   │   ├── GqlApiCtx.ts
│   │   ├── out_type_defs.ts
│   │   └── schema.gql
│   ├── deno.json
│   ├── deno.lock
│   ├── example_codegen -> ../example_codegen/core
│   ├── justfile
│   └── main.ts
├── JUSTFILE
├── README.md
└── VERSION.md
```

1. Though this is the root folder of the project - it is not treated as for
   development, only for declaration members
2. So here we have 2 members - `example_codegen` and `example_v1`
3. They are independent from `app/lib` definitions
4. The only matter - is the `core` folder in any member
5. So here `example_codegen/core` - is the place that can be shared
6. `example_v1` is use this `example_codegen/core` as library
7. It is also mean, that `example_codegen` can also use own `core` stuff but in
   own way
8. How link members? `just app_lib_link <app> <lib> <alias:optional>`. So to
   produce example, the command `just app_lib_link example_v1 example_codegen`
   was executed
9. The main goal of all this project - is possibility to open any of the members
   as root folder
10. To focus on development `example_v1` you should simple open this folder _(as
    helper, the command `just example_v1 cd`)_
    - And so your tree will become:
      ```
      .
      ├── codegen
      │   ├── config.ts
      │   ├── GqlApiCtx.ts
      │   ├── out_type_defs.ts
      │   └── schema.gql
      ├── deno.json
      ├── deno.lock
      ├── example_codegen -> ../example_codegen/core
      ├── justfile
      └── main.ts
      ```
11. **And in such way you can quickly change your root and focus on this
    application**

12. Explore and update `justfile`s content - this is simple and straightforward
    way to organize any monorepo-like tasks
13. Another helper - is bumping versions
    - Open `.justfile/bump.just` and update list of the json files with version
    - Update `VERSION.md`
    - `just bump`

# TODO:

Among many todos the first one - sometimes it is actual to replace links with
copies of the source folders for some deployment systems for example. Will be
cool to have simple task, command for this purpose.

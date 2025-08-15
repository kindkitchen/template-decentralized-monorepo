# About

This is simple and straightforward aka monorepo/workspace solution.

## What it is different from popular solutions?

Technically it is pretty different thing I suppose. Because the main mechanism
is focused on utilizing justfile scripts, linking directories and **dynamically
switching the root of the project**.

So the main idea to not have a `monorepo` with many apps, libs etc.. But have
**single `app`** opened at current time.

## Benefits:

1. It is very simple! _Though it may looked opposite, but it is only because the
   whole logic is written directly here, any magic until you have some
   experience with bash and so on. You can simple extend, modify any part of
   this configuration. Be free to make issues, pull request!_
2. This approach try to avoid any possible problems related to monorepos because
   it is change self instead of adopting codebase. _For example some frameworks
   can have pretty strict opinnionations about how and where they should be
   placed and not be friendly to monorepos. But this solution will simply change
   directory and it will looked like the app is normal mode_

# Some details:

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

# TODO:

Among many todos the first one - sometimes it is actual to replace links with
copies of the source folders for some deployment systems for example. Will be
cool to have simple task, command for this purpose.

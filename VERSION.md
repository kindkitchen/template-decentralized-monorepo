# 0.2.0

## `.github/workflows/deploy.yml`

> The example with pre-configured common stuff for deploy.

## `~/deno.json` the root of the project

> So this is the deno workspace feature

## `domain` => `@/domain` the domain logic

> As possible any knowledge about implementation details. Simply export nearly
> business ready types etc.

## `app/*` => `@app/*` applications

## `lib/*` => `@lib/*` libs

## `VERSION.md` the source of project's version with optional description

> The only requirement for this file - the first line should contain valid
> semver version _(possibly prefixed with markdown heading... this is actually
> current file by the way)_

## `JUSTFILE` the centralized source for task execution outside code

> Feel free to extend this file with your tasks. _(below the explanation for
> default ones)_

1. `just v` - simply display current version of the project _(declared in
   VERSION.md first line)_
2. `just bump` - update version in all declared `*.json` `.` `version` files
   - _the most common candidate is `package.json`_
   - but in any case - the paths to these files is read from
     `JSON_FILES_WITH_VERSION` variable _(also declared in `JUSTFILE`, expect
     string - the split by space paths)_
3. The rest `tasks` declared as examples and as example utilize the very very
   bestest js runtime - [Deno](https://deno.com)
   - `fmt` format project _(declared first, so will be executed by default, with
     simple `just` - for details see
     [Justfile documentation](https://just.systems/man/en/))_
   - `install`

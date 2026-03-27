> [source](README.md)

# About

> Read comments in `.just/*` files


---
---
---



> [source](VERSION.md)

# 0.1.0


---
---
---



> [source](project_support/src/lib/llm_txt_from_all_md.md)

##### About

Recursively aggregate all markdown files content from provided root into the
`llm.txt` file.

###### Options

- `root` - the root directory from where to start
- `followSymlinks` - ignore or follow symlinks


---
---
---



> [source](util_xstate/src/lib/guard_is_output_left.md)

#### `is_output_left`

- Check that the `event.output` is typeof `Either.Either.Left`
- **Do not check, that the event has output or it is of either type!**


---
---
---



> [source](util_xstate/src/lib/guard_is_output_right.md)

#### `is_output_right`

- Check that the `event.output` is typeof `Either.Either.Right`
- **Do not check, that the event has output or it is of either type!**


---
---
---



> [source](util_xstate/src/lib/im_sure.md)

## `im_sure.*` semantic

> As a developer I'm sure, that in this place I can do this or this.

This is mostly helpers, that tip typescript **without** actual check. Make some
simple transformation.

#### What is the goal?

Make code more readable, enforce to be in touch with some conventions to be sure
in some expectations.

#### How I can be sure?

As mentioned earlier - if you follow the convention, declared in documentation -
you can expect some behavior etc. So be careful - this may turn against you if
you ignore it.

## Context of this statements

The main part of assumptions is related to `xstate` - `effect` integration.

- Actor, resolved with `onDone` explicitly converted to effect's `Either` type.
  So instead of success - the `left` _(controlled fail)_ and `right` _(actual
  success)_ flows are represented.
- `onError` still real, unexpected _panic_ place - still be **unknown**
- All these happen in convenient way in the internal states of some _parent_
  state, which is contained _effect-full_ **actor**
- The declaration of such flow expected to be _copy-pasted_
- The _business_ state with such actor has private children:
  - _Enter_
  - _Compute_
  - _Done_
  - _Success_
  - _Exception_
  - _Error_

#### So with correct usage - **you can be sure in some types, possibility to make some transformations, etc.**


---
---
---



> [source](util_xstate/src/lib/logic_from_declared_effect.md)

## Transform effect, declared in context into promise logic

> This is opinionated abstraction over the original `promise_logic_from_effect`
> function.

#### I want to understand how it works!

> As already mentioned earlier - explore
> [./promise_logic_from_effect.md]([./promise_logic_from_effect.md]) first.

But the core idea is to wrap builtin `fromPromise` actor.

And also utilize context - so we make some conventions, where place actors and
that they should be of some type - and so we declare `input` that is the same as
our `context`... _what a fortune! :D_

#### Pros & Cons

This is a sacrifice of interface independency for sugar usage! The transformer
make assumption about where fn => effect should be placed. It should be placed
in { Actor: Record<name, here!> }. The reason for such design is practical
usage, when such object may simply be a context of the machine.

#### Conclusion

- The Actor[key] has shape as `() => Effect` and it should be located in
  `context.Actor["example"]`.
- So the main goal - is totally free machine from any implementations.
- Though they are still present in context.Actor - possibly it will be mapped
  here from `input`
- Both <Success> and <Error> channels from <Effect> is piped to <onDone> but
  wrapped into <Either>.
- So into <onError> will be passed <Panic>


---
---
---



> [source](util_xstate/src/lib/promise_logic_from_effect.md)

# About `promise_from_effect` function

```ts
import { createActor, setup, toPromise } from "xstate";
import { Effect, Either, Layer } from "effect";
import { promise_logic_from_effect } from "./promise_logic_from_effect.ts";

const machine = setup({
    actors: {
        example: promise_logic_from_effect((x: number) =>
            Effect.gen(function* () {
                if (x < 0.1) {
                    throw new Error("Boom!");
                } else if (x < 0.5) {
                    yield* Effect.fail("Oops...");
                }

                return "Ok";
            })
        ),
    },
})
    .createMachine({
        initial: "Start",
        states: {
            Finish: {
                type: "final",
            },
            Start: {
                invoke: {
                    src: "example",
                    input: {
                        args: [Math.random()],
                        layer: Layer.empty,
                    },
                    onDone: {
                        target: "Finish",
                        actions: ({ event }: any /// this will not be any in real typescript file (but here to be able run this md example with `deno test --doc`)
                        ) => {
                            if (Either.isRight(event.output)) {
                                console.info("Success:", event.output.right);
                            } else {
                                console.warn("Fail:", event.output.left);
                            }
                        },
                    },
                    onError: {
                        target: "Finish",
                        actions: ({ event }: any /// this will not be any in real typescript file (but here to be able run this md example with `deno test --doc`)
                        ) => {
                            console.error("Panic:", event.error);
                        },
                    },
                },
            },
        },
    });

await toPromise(createActor(machine).start());
```


---
---
---



> [source](util_plopper/src/lib/x_plopper/README.md)

# About

This is code-generators for some opinionated xstate declaration strategies.

## What problems it should solve?

The main problem, that this library is try to solve is integration of 2 major
advantages of xstate. So what we are speaking about?

1. Ability to express logic of any difficulty level
2. Ability to produce impressive and interactive state-charts

Though these are the 2 main reasons why I like to use xstate - sometimes I need
to make some sacrifices on one of them to still have both.

So yes, the main problem is that generation of state-charts require from code
some implicit rules and pretty often they are not friendly to developer's
intentions or flavors how this code should be written.

Simply speaking - with machine growing, though logic still be controlled by
xstate the code itself become less readable because of requirements to be parsed
into state-charts.

## How these problems will be solved?

Rude and simple - by code-generation. So this library provide some variants,
templates that will be used as cli command and generate in deterministic way
some parts of machine etc.. So developer will have ability to write code in
different files, use more dynamic stuff etc. - but it will still produce
state-chart friendly machine definitions at once.

**No matter how it sounds to you - awful or cool - the truth is somewhere
between I guess - so below explore both cons and pros that are already known**

## Pros

- Less boilerplate
- More readable code
- Intention to write code with some clean conventions

## Cons

- Obviously these generators as state-charts - in some way also opinionated
  about how your code should be looked
- The patterns, strategies, conventions may not fit your expectations
- Code-generators...

# Implementation progress

1. Declare type of `x` constant that should be auto-generated from minimalistic
   declaration of itself
2. Introduce the idea of **twicert** code-generation
   > The analogy of play words in `upsert` term. But here it means that
   > internally generator will produce some intermediate output and then final.
   > So the developer's config will generate some files and from these files
   > will be generated result. Though it sounds too complicated in fact it is
   > only for simplicity in usage
3. So code-generation will check, does some external files/definitions exists,
   that fit minimalistic input and if no - create them and use, if yes - use at
   once.
4. This intermediate files are the place where developer can more detailed
   extend his definition
5. So instead of introducing more options in initial config - some files-tree
   will be generated - which mirrors initial config


---
---
---



> [source](util_plopper/src/lib/x_plopper/fixture/x_state_init.md)

## Init

> this markdown description can be modified in `x_state_init.md` file


---
---
---



> [source](util_plopper/src/lib/x_plopper/fixture/x_state_step_1.md)

## Step 1

> this markdown description can be modified in `x_state_step_1.md` file


---
---
---



> [source](util_plopper/src/lib/x_plopper/fixture/x_state_step_2.md)

## Step 2

> this markdown description can be modified in `x_state_step_2.md` file


---
---
---




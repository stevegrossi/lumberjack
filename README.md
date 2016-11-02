# Lumberjack

This repo contains examples referred to in a talk to [Indy Elixir](http://www.indyelixir.org/) entitled “All the World’s a GenStage” ([slides](http://work.stevegrossi.com/talks/all-the-worlds-a-gen-stage/))

## Simple Example: A Counter

This example (from [the GenStage docs](https://hexdocs.pm/gen_stage/Experimental.GenStage.html)) has a producer which counts integersup from infinity and a consumer which prints those integers.

```shell
$ git checkout counter
$ mix run --no-halt

{#PID<0.144.0>, 39162}
{#PID<0.144.0>, 39163}
{#PID<0.144.0>, 39164}
{#PID<0.144.0>, 39165}
{#PID<0.144.0>, 39166}
{#PID<0.144.0>, 39167}
{#PID<0.144.0>, 39168}
```

Now we add some concurrency: note the four different PIDs printing integers.

```shell
$ git checkout concurrent-counter
$ mix run --no-halt

{#PID<0.147.0>, 75490}
{#PID<0.146.0>, 76410}
{#PID<0.144.0>, 75864}
{#PID<0.145.0>, 76833}
{#PID<0.147.0>, 75491}
{#PID<0.146.0>, 76411}
```

Now we add a `producer_consumer` which multiplies each integer by a factor of two before printing. Note that all integers are now even:

```shell
$ git checkout multiplier
$ mix run --no-halt

{#PID<0.159.0>, 104736}
{#PID<0.160.0>, 106428}
{#PID<0.158.0>, 103896}
{#PID<0.161.0>, 105334}
{#PID<0.159.0>, 104738}
{#PID<0.161.0>, 105336}
{#PID<0.159.0>, 104740}
{#PID<0.158.0>, 103898}
```

## Practical Example: Log Parsing

This example uses a producer to stream lines from a web application log, a producer-consumer to extract the response times, and a consumer to aggregate those response times into a running average.

```shell
$ git checkout log-parser
$ mix run --no-halt

Average: 507.232
Average: 508.536
Average: 512.5973333333334
Average: 511.708
Average: 510.8528
Average: 513.324
...
Average: 511.3170101010101
Average: 511.28474371859295
Average: 511.334
```

As more lines are parsed, you’ll see the running average converge on the overall average.

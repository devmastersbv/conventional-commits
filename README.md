# Conventional commit tag generator

Generates tags based on commits. Uses convential commit specification. See [conventialcommits.org](https://www.conventionalcommits.org/en/v1.0.0/) for a detailed specification. Only the basics will be outlined here

## Basics
This script generates the next tag version based on commits messages since last tag (version) to determine if either the major, minor or patch need to be incremented. The messages should contain a `type` (see below).

### Patch
`fix:` or `improvement:` increments the patch version

### Minor
`feat:` or `performance:` increments the minor version. `feature:` is also accepted.

### Major / Breaking changes
`!` after the previously mentioned `type` denotes a breaking change. For example `fix!:`. This increments the major version.

### Non-impacting commit messages
Some commits don't need to change the version. Examples of types to use in such cases include but are not limited to
`build:`, `chore:`, `ci:`, `docs:`, `style:`, `refactor:`, `perf:`, `test:`

## Usage
```sh
./generate-tag.sh
```

## Todo
Include docker/cloudbuild files. Any contributions or comments are welcome!

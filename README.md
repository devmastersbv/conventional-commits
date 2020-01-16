# Conventional commit RC tag generator

Generates release candidate tags based on commits. Uses angular conventional commit specification.

## Basics
This script generates the next RC tag version based on commits messages since last tag (version) to determine if either the major, minor or patch need to be incremented. The messages should contain a `type` (see below).

### Patch
`fix:` or `improvement:` increments the patch version

### Minor
`feat:` or `performance:` increments the minor version. `feature:` is also accepted.

### Major / Breaking changes
`!` after the previously mentioned `type` denotes a breaking change. For example `fix!:`. This increments the major version.

### Non-impacting commit messages
Some commits don't need to change the version. Examples of types to use in such cases include but are not limited to
`build:`, `chore:`, `ci:`, `docs:`, `style:`, `refactor:`, `test:`

## Usage
```sh
./generate-tag.sh
```

### SHA
SHA can be included in case you run this on multiple staging environments.
```sh
./generate-tag.sh --sha
```

## Contributions
Any contributions or comments are welcome!

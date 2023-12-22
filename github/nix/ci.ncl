# SPDX-FileCopyrightText: 2023 The omnibus-ncl Authors
# SPDX-FileCopyrightText: 2023 tf-ncl
#
# SPDX-License-Identifier: MIT

{
  name = "CI",
  on = {
    push = {
      branches = ["main"]
    },
    pull_request = {
      branches = ["main"]
    }
  },

  configs = [
    { os = "ubuntu-latest" },
    # See https://github.blog/2023-10-02-introducing-the-new-apple-silicon-powered-m1-macos-larger-runner-for-github-actions/
    { os = "macos-latest-large" }
  ],

  concurrency = {
    group = "ci-${{ github.ref }}",
    cancel-in-progress = true
  },

  matrix = {
    config | default = { os = "" },

    name = "Build and Test",

    job = {
      steps =
        (import "setup-steps.ncl")
        @ [
          {
            run = m%"
              nix flake check --print-build-logs
            "%,
            name = "Run flake check"
          },
        ],
      runs-on = config.os,
    }
  },
}
& (import "../matrix.ncl")
|> std.serialize 'Json
|> std.deserialize 'Json
  | (import "../github-workflow.schema.ncl")

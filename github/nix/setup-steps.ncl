# SPDX-FileCopyrightText: 2023 The omnibus-ncl Authors
# SPDX-FileCopyrightText: 2023 tf-ncl
#
# SPDX-License-Identifier: MIT
[
  { uses = "actions/checkout@v4" },
  {
    uses = "DeterminateSystems/nix-installer-action@main",
    # https://github.com/DeterminateSystems/nix-installer-action
    name = "Installing Nix",
    with = {}
  },
  {
    name = "Setup Cachix",
    with = {
      authToken = "${{ secrets.CACHIX_TWEAG_NICKEL_AUTH_TOKEN }}",
      name = ""
    },
    uses = "cachix/cachix-action@v12"
  },
  {
    name = "Setup nix-cache",
    uses = "DeterminateSystems/magic-nix-cache-action@main",
    with = {
      github_token = "${{ secrets.GITHUB_TOKEN }}",
    },
  }
]

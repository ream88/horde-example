# A Elixir cluster example using horde

This is an example of an Elixir app which allows rolling deploys using [`horde`](https://hex.pm/packages/horde).

```sh
iex --name a -S mix
iex --name b -S mix
```

```sh
App.start_worker(:alice)
App.start_worker(:bob) # On node b
```

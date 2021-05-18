# SimpleFileServer.jl

Run a simple HTTP file server, serving files from the given local directory.

```julia
julia> import Pkg; Pkg.add(url="https://github.com/fonsp/SimpleFileServer.jl")

julia> using SimpleFileServer

julia> serve(".")
HTTP server listening on http://0.0.0.0:4507/
```

## Details

The server is running on [deno](https://deno.land/), using the [`file_server` standard library](https://deno.land/manual/examples/file_server). We use the cross-platform [`Deno_jll`](https://github.com/JuliaBinaryWrappers/Deno_jll.jl) package for the deno binary (30MB).

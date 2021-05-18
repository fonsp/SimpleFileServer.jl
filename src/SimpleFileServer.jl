"""
See [`SimpleFileServer.serve`](@ref) to run the file server.
"""
module SimpleFileServer

using Deno_jll

export serve

"""
    serve(dir="."; <keyword arguments>)

Run a simple HTTP file server, serving files from the given local directory.

The server is running on [deno](https://deno.land/), using the [`file_server` standard library](https://deno.land/manual/examples/file_server).

# Arguments
- `cors::Bool=false`: Enable CORS via the "Access-Control-Allow-Origin" header.
- `port::Integer=4507`: Set port.
- `host="0.0.0.0"`: Hostname (default is 0.0.0.0, another common choice is 127.0.0.1).
- `dir_listing::Bool=true`: Show a directory listing for folders with no `index.html` file.
- `dotfiles::Bool=true`: Also show dotfiles in directory listings.
- `tls_certificate_file::Union{Nothing,String}=nothing`: TLS certificate file (enables TLS).
- `tls_key_file::Union{Nothing,String}=nothing`: TLS key file (enables TLS).

All TLS options are required when one is provided.
"""
function serve(dir::String=".";
    port::Integer=4507,
    host="0.0.0.0",
    cors::Bool=false,
    dir_listing::Bool=true,
    dotfiles::Bool=true,
    tls_certificate_file::Union{Nothing,String}=nothing,
    tls_key_file::Union{Nothing,String}=nothing,
)

    args = []

    push!(args, "--port", string(port))
    push!(args, "--host", string(host))

    if cors
        push!(args, "--cors")
    end
    if !dir_listing
        push!(args, "--no-dir-listing")
    end
    if !dotfiles
        push!(args, "--no-dotfiles")
    end

    if tls_certificate_file !== nothing
        push!(args, "--cert", tls_certificate_file)
    end
    if tls_key_file !== nothing
        push!(args, "--key", tls_key_file)
    end

    run(`$(deno()) run --allow-net --allow-read https://deno.land/std@0.97.0/http/file_server.ts $(dir) $(args)`)
end
end

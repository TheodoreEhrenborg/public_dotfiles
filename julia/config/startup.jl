atreplinit() do repl
    try
        @eval using Revise
    catch e
        @warn "error while importing Revise" e
    end
end
atreplinit() do repl
    try
        @eval using OhMyREPL
    catch e
        @warn "error while importing OhMyREPL" e
    end
end
atreplinit() do repl
    try
        @eval using REPLference
    catch e
        @warn "error while importing REPLference" e
    end
end

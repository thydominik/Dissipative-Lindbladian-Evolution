module Validation

"""
    check_args(args...; kw...)
Macro to check function arguments for type and bounds.
Macros in Julia cannot create decorators but you can make checks reusable.
"""
macro check_args(ex...)
    quote
        for pair in Expr(:tuple, ex...)
            eval(pair)
        end
    end
end

"""
    assert_positive(x, name::String)
Check if scalar x > 0.
"""
function assert_positive(x, name::String)
    x > 0 || throw(ArgumentError("$name must be positive"))
end

end # module Validation

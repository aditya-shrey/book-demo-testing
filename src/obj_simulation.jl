using Plots

# Struct to represent the object's state.
mutable struct Object
    x::Float64
    y::Float64
    v::Float64
    θ::Float64
end

# Function to update the object's state.
function update_pos(obj::Object, Δt::Float64, v::Float64, θ::Float64)
    obj.x += v * cos(θ) * Δt
    obj.y += v * sin(θ) * Δt
    obj.v = v 
    obj.θ = θ
end

# Function to simulate the object's movement and create a real-time animation.
function simulate_and_animate(obj::Object, Δt::Float64, v::Float64, θ::Float64, T::Float64)
    anim = @animate for t in 0:Δt:T
        update_pos(obj, Δt, v, θ)
        plot([obj.x], [obj.y], seriestype=:scatter, xlim=(-1, T*v*cos(θ)+1), ylim=(-1, T*v*sin(θ)+1),
             xticks=nothing, yticks=nothing, grid=true, framestyle=:box, legend=false)
    end
    return anim
end

# Function to run the simulation and display the animation.
function run_simulation()
    obj = Object(0.0, 0.0, 0.0, 0.0)
    Δt = 0.1
    v = 1.0
    θ = π/4
    T = 10.0
    anim = simulate_and_animate(obj, Δt, v, θ, T)
    gif(anim, "object_movement.gif", fps=10)
end

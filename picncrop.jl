using GLMakie
using FileIO
using ImageIO
img = load("/home/josselin/files/dh/code-code-codex/julia/input.png")

images = img
images
fig = Figure()

i_slice = Observable(1)

ax =    Axis(
            fig[1, 1],
            aspect = DataAspect(), 
            yreversed = true,
            title = @lift("Slice $($i_slice)")
        )
hidedecorations!(ax)

chosen_slice = @lift(images[:, :, $i_slice]')

i = image!(ax, chosen_slice)
translate!(i, 0, 0, -5)

buttongrid = fig[1, 2] = GridLayout(tellheight = false)
b = Button(buttongrid[1, 1], label = "Save crop")
b2 = Button(buttongrid[2, 1], label = "Next image")
b3 = Button(buttongrid[3, 1], label = "Previous image")

on(b.clicks) do c
    lims = ax.finallimits[]
    
    mini, maxi = extrema(lims) # get the bottom left and top right corners of `lims`
    mini = round.(Int, mini) # to index into an image, which is an array, we need ints
    maxi = round.(Int, maxi) # and the axis bounding box is always represented in floats
    cropped_slice = chosen_slice[][mini[1]:maxi[1], mini[2]:maxi[2]]
    save("output_$(i_slice[]).png", cropped_slice)
end

on(b2.clicks) do c
    i_slice[] = mod1(i_slice[] + 1, 150)
    autolimits!(ax)
end

on(b3.clicks) do c
    i_slice[] = mod1(i_slice[] - 1, 150)
    autolimits!(ax)
end

fig
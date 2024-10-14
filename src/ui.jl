# Struct pour gérer les boutons
struct Buttons
    save::Button
    next::Button
    previous::Button
    reload::Button
end

# Fonction pour configurer l'axe d'affichage de l'image
function setup_axis(fig, imageName)
    ax = Axis(
        fig[1, 1],
        aspect = DataAspect(),
        yreversed = true,
        title = imageName
    )
    hidedecorations!(ax)
    return ax
end

# Fonction pour afficher l'image
function display_image(ax, imageObservable)
    img = image!(ax, imageObservable)
    translate!(img, 0, 0, -5)
    return img
end

# Fonction pour configurer les boutons
function setup_buttons(fig)
    buttongrid = fig[1, 2] = GridLayout(tellheight = false)
    b_save = Button(buttongrid[1, 1], label = "Save crop")
    b_next = Button(buttongrid[2, 1], label = "Next image")
    b_prev = Button(buttongrid[3, 1], label = "Previous image")
    b_reload = Button(buttongrid[4, 1], label = "Reload")
    return Buttons(b_save, b_next, b_prev, b_reload)  # Retourner une instance de Buttons
end

# Fonction pour configurer les callbacks des boutons
function setup_button_callbacks(ax, imageObservable, image, input, path, buttons::Buttons)
    on(buttons.save.clicks) do _
        save_crop(ax, imageObservable, basename(input[image[]]), path)
    end

    on(buttons.next.clicks) do _
        image[] = mod1(image[] + 1, length(input))
        autolimits!(ax)
    end

    on(buttons.previous.clicks) do _
        image[] = mod1(image[] - 1, length(input))
        autolimits!(ax)
    end

    on(buttons.reload.clicks) do _
        image[] = mod1(image[], length(input))
        autolimits!(ax)
    end
end
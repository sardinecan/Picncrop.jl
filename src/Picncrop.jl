module Picncrop

using GLMakie
using FileIO
using ImageIO

include("images.jl")
include("fileManagement.jl")
include("ui.jl")

# Fonction principale pour lancer le cropper
function launch_cropper(path)
    # Définir les extensions valides et charger les images
    extensions = ["jpg", "JPG", "jpeg", "png", "PNG", "tif", "tiff"]
    images, input = load_images(path, extensions)

    # Créer la figure et l'observable pour l'image actuelle
    fig = Figure()
    image = Observable(1)
    imageName = @lift(basename(input[$image]))

    # Configurer l'axe et afficher l'image
    ax = setup_axis(fig, imageName)
    selectedImage = @lift(images[$image]')
    img = display_image(ax, selectedImage)

    # Configurer les boutons et les callbacks
    buttons = setup_buttons(fig)
    setup_button_callbacks(ax, selectedImage, image, input, path, buttons)

    # Afficher la figure
    return fig
end

end # module Picncrop

# Appel de la fonction pour lancer le cropper
Picncrop.launch_cropper("/home/josselin/files/dh/picncrop/input/")

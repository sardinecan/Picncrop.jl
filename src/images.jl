# Fonction pour charger les images à partir du répertoire
function load_images(path, extensions)
    input = readdir(path, join=true)
    filter!((file) -> any(endswith(file, ext) for ext in extensions), input)
    return [load(image) for image in input], input
end
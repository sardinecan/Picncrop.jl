# Fonction pour générer un nom de fichier unique pour le crop
function get_unique_filename(basename, outputpath)
    ext = split(basename, ".")[end]  # Extraire l'extension du fichier
    filename = "$(outputpath)/$(basename).crop.$(ext)"
    counter = 1
    while isfile(filename)
        filename = "$(outputpath)/$(basename).crop_$(counter).$(ext)"
        counter += 1
    end
    return filename
end

# Fonction pour sauvegarder le crop de l'image
function save_crop(ax, imageObservable, imageName, path)
    lims = ax.finallimits[]
    mini, maxi = extrema(lims)
    mini = round.(Int, mini)
    maxi = round.(Int, maxi)
    croppedImage = imageObservable[][mini[1]:maxi[1], mini[2]:maxi[2]]
    
    output_dir = joinpath(path, "output") 
    if isdir(output_dir) == false
        mkdir(output_dir)
    end
    
    filename = get_unique_filename(imageName, output_dir)
    println("saved " * filename)
    save(filename, rotl90(croppedImage[:, end:-1:1]))  # Enregistrer l'image directement sans rotation
end
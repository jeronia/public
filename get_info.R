#Seleccionar directori
setwd('C:/Users/jeron/Desktop') #canvia pel directori on tinguis l'excel

get_info <- function(excel, api_key){
    
    #Instal·lar i obrir packages
    packages <- c('openxlsx', 'ggplot2', 'ggmap', 'RCurl', 'jsonlite')
    installed_packages <- packages %in% rownames(installed.packages())
    if (any(installed_packages == FALSE)) {
        install.packages(packages[!installed_packages])
    }
    lapply(packages, library, character.only = TRUE)
    
    #Obrir excel
    data <- read.xlsx(excel) 
    
    #Introduir clau api
    register_google(key = api_key)
    
    #Localitza empresa
    for(i in 1:nrow(data)){
        #Geolocalitzar empreses
        geodata <- geocode(data$name[i], output = "all", source = "google") #canvia data$name per data$ i el nom de la columna d'excel on figuri el nom de l'empresa (o abans d'obrir l'excel canvia el nom de la columna a "name")
        if(geodata[["status"]]=='OK') {
            #Crear variable address
            data$address[i] <- as.character(geodata[["results"]][[1]][["formatted_address"]])
            #Crear variable city
            data$city[i] <- as.character(geodata[["results"]][[1]][["address_components"]][[3]][["long_name"]])
            #Crear variable postal_code
            data$postal_code[i] <- as.character(geodata[["results"]][[1]][["address_components"]][[7]][["long_name"]])
            #Cercar id de l'empresa
            place_id <- as.character(geodata[["results"]][[1]][["place_id"]])
            url_place <- paste0("https://maps.googleapis.com/maps/api/place/details/json?place_id=", place_id,
                                "&fields=formatted_phone_number,website&key=", api_key)
            place_json <- getURL(url_place)
            #Obtenir detalls de l'empresa
            place_details <- fromJSON(place_json, simplifyVector = TRUE)
            #Marcar com a NA si manca phone_number
            if(is.null(place_details[["result"]][["formatted_phone_number"]])){
                data$phone_number[i] <- NA
            } else {
                #Crear variable phone_number
                data$phone_number[i] <- place_details[["result"]][["formatted_phone_number"]]
            }
            #Marcar com a NA si manca website
            if(is.null(place_details[["result"]][["website"]])){
                data$website[i] <- NA   
            } else {
                #Crear variable website
                data$website[i] <- place_details[["result"]][["website"]]
            }}}
    #Guardar com a excel
    write.xlsx(data, 'data_trans.xlsx')
}

get_info('example.xlsx','xxx') #canvia pel teu nom d'excel i la clau API

get_info <- function(excel, api_key){
    
    #Install (if needed) and open packages
    packages <- c('openxlsx', 'ggplot2', 'ggmap', 'RCurl', 'jsonlite')
    installed_packages <- packages %in% rownames(installed.packages())
    if (any(installed_packages == FALSE)) {
        install.packages(packages[!installed_packages])
    }
    lapply(packages, library, character.only = TRUE)
    
    #Read excel
    data <- read.xlsx(excel) 
    
    #Insert API kei
    register_google(key = api_key)
    
    #Locate company
    for(i in 1:nrow(data)){
        #Geocode company
        geodata <- geocode(data$name[i], output = "all", source = "google") #change data$name for data$ and the name of the column which contains company names
        if(geodata[["status"]]=='OK') {
            #Create variable address
            data$address[i] <- as.character(geodata[["results"]][[1]][["formatted_address"]])
            #Create variable city
            data$city[i] <- as.character(geodata[["results"]][[1]][["address_components"]][[3]][["long_name"]])
            #Create variable postal_code
            data$postal_code[i] <- as.character(geodata[["results"]][[1]][["address_components"]][[7]][["long_name"]])
            #Identify company id
            place_id <- as.character(geodata[["results"]][[1]][["place_id"]])
            url_place <- paste0("https://maps.googleapis.com/maps/api/place/details/json?place_id=", place_id,
                                "&fields=formatted_phone_number,website&key=", api_key)
            place_json <- getURL(url_place)
            #Get company details
            place_details <- fromJSON(place_json, simplifyVector = TRUE)
            ##Get rid of NULLs
            if(is.null(place_details[["result"]][["formatted_phone_number"]])){
                data$phone_number[i] <- NA
            } else {
                #Create variable phone_number
                data$phone_number[i] <- place_details[["result"]][["formatted_phone_number"]]
            }
            ##Get rid of NULLs
            if(is.null(place_details[["result"]][["website"]])){
                data$website[i] <- NA   
            } else {
                #Create variable website
                data$website[i] <- place_details[["result"]][["website"]]
            }}}
    #Save as excel
    write.xlsx(data, 'data_trans.xlsx')
}

#Example
get_info('example.xlsx','xxx') #try it with your own excel file and api key

#' This is a function used to compare the evolution of inhabitation numbers of 
#' swedish municipalities
#'
#' This function takes two names of swedish municipalities as arguments and
#' returns either a plot of the progression of their inhabitant numbers or
#'  (if the return_data argument is TRUE) returns a data.frame with the inhabitant
#'  data of those municipalities. Data usually exists for the period 1970-2021.
#'  
#' @param municipality1 The first municipality to be compared. 
#' ATTENTION: Exact spelling including special letters is needed (e.g. ö)
#' @param municipality2 The second municipality to be compared
#' ATTENTION: Exact spelling including special letters is needed (e.g. ö)
#' @param return_data Per default this is FALSE, if it is TRUE no plot is 
#'  output, instead a data.frame is returned
#'  
#' @export
#' @import httr
#' @importFrom  jsonlite fromJSON
#' @import ggplot2
#' @import scales
#' 
#' @examples 
#' compare_inhabitants("Linköping","Norrköping")
#' compare_inhabitants("Linköping","Norrköping", return_data = TRUE)
#' 
#' 

compare_inhabitants = function(municipality1, municipality2, return_data = FALSE){
  #TODO error handling (wrong inputs) and maybe more functionality (other KPIs)
  # Helpful resources: 
  # https://github.com/Hypergene/kolada 
  # https://www.linkoping.se/open/data/nyckeltal-fran-kolada/ 
  # https://www.kolada.se/om-oss/api/ 
  
  # Function to make API calls to receive the code for the municipality that we 
  # need to make the API call for the inhabitants
  if (!is.logical(return_data)){
    stop("The return_data argument should be logical (TRUE or FALSE).", call. = FALSE)
  }
  if (!is.character(municipality1) || !is.character(municipality2)){
    stop("The inputs should be strings.", call. = FALSE)
  }
  
  if (municipality1 == municipality2){
    stop("Please select two different municipalities.", call. = FALSE)
  }
  get_municipality_code = function(municipality_name){
    url = "http://api.kolada.se/v2/"
    request_url = paste(url,"municipality?title=",municipality_name,sep = "") # build request URL
    response = GET(request_url)
    response_content = content(response,"text")
    response_json = fromJSON(response_content,flatten = TRUE)
    if (length(response_json$values) == 0){
      stop(paste("\"", municipality_name, "\" municipality is not in the database.", sep=""), call. = FALSE)
    }
    response_df = as.data.frame(response_json)
    id = ""
    #Explanation: Sometimes you get 2 codes as a response, one with code "K" 
    # and one with code "L". We only care about "K" so this ensures we get the
    # right one
    if(nrow(response_df) == 1){
      id = response_df[1,]$values.id
    } else {
      if(response_df[1,]$values.type == "K"){
        id = response_df[1,]$values.id
      } else {
        id = response_df[2,]$values.id
      }
    }
    return(id)
  }
  
  #get codes
  municipality1_code = get_municipality_code(municipality1)
  municipality2_code = get_municipality_code(municipality2)
  kpi_code = "N01951"   # N01951 is code for inhabitant KPI 
  
  get_inhabitants = function(municipality_code){
    url = "http://api.kolada.se/v2/data/"
    
    request_url = paste(url,"municipality/",municipality_code,"/kpi/",kpi_code,sep = "")
    response = GET(request_url)
    response_content = content(response,"text")
    response_json = fromJSON(response_content,flatten = TRUE)
    
    # this is necessary because the total inhabitant number sits in a nested data.frame
    # This way we get this data cleanly
    total_inhabitants = unlist(lapply(1:nrow(response_json$values), function(x) response_json$values[[x,4]][[3,4]]))
    # build and return a data.frame with only the information we care about
    response_data = data.frame("municipality" = response_json$values$municipality,"year" = response_json$values$period,
                                "inhabitants" = total_inhabitants)
    return(response_data)
  }
  
  data1 = get_inhabitants(municipality1_code)
  data2 = get_inhabitants(municipality2_code)
  
  #merge the two data.frames to one by their year
  combined = merge(data1,data2, by.x="year",by.y = "year")
  #set column names
  colnames(combined) = c("year","municipality_code.1",paste("Inhabitants.",municipality1,sep=""),
                         "municipality_code.2",paste("Inhabitants.",municipality2,sep=""))
  return_plot = ggplot(data=combined, aes_string(x="year")) +
      geom_line(aes(y=.data[[paste("Inhabitants.",municipality1,sep="")]],colour=municipality1)) +
      geom_line(aes(y=.data[[paste("Inhabitants.",municipality2,sep="")]], colour=municipality2)) +
      ylab("Inhabitants") + labs(color = "Municipality") + scale_y_continuous(labels = scales::comma)
  
  ifelse(return_data, return(combined),return(return_plot))
}

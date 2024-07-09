# Set the CRAN mirror
options(repos = c(CRAN = "https://cran.r-project.org"))

install.packages("plumber")
install.packages("mongolite")
install.packages("jsonlite")
install.packages("testthat")

# Load required libraries
library(plumber)
library(mongolite)
library(jsonlite)

# MongoDB connection
db <- mongo(collection = "data", db = "my_database", url = "mongodb://localhost")

#* @apiTitle JSON Storage API

#* Store JSON data
#* @param data:json
#* @post /data
function(data) {
  result <- db$insert(data)
  list(id = result)
}

#* Retrieve JSON data by ID
#* @param id
#* @get /data/<id>
function(id) {
  result <- db$find(sprintf('{"_id": {"$oid": "%s"}}', id))
  if (length(result) == 0) {
    res$status <- 404
    return(list(error = "Data not found"))
  }
  result
}

#* Update JSON data by ID
#* @param id
#* @param data:json
#* @put /data/<id>
function(id, data) {
  result <- db$update(sprintf('{"_id": {"$oid": "%s"}}', id), data)
  if (result$nModified == 0) {
    res$status <- 404
    return(list(error = "Data not found"))
  }
  list(success = TRUE)
}

#* Delete JSON data by ID
#* @param id
#* @delete /data/<id>
function(id) {
  result <- db$remove(sprintf('{"_id": {"$oid": "%s"}}', id))
  if (result$nRemoved == 0) {
    res$status <- 404
    return(list(error = "Data not found"))
  }
  list(success = TRUE)
}

# Run the API
pr <- plumber$new()
pr$run(host = "0.0.0.0", port = 8000)

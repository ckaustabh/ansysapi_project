FROM r-base

# Install R packages
RUN R -e "install.packages(c('plumber', 'mongolite', 'jsonlite', 'testthat'), repos='http://cran.rstudio.com/')"

# Copy API script
COPY api.R /app/api.R

# Set working directory
WORKDIR /app

# Expose port
EXPOSE 8000

# Run the API
CMD ["Rscript", "api.R"]

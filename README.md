# get_info
Function to get information (such as address, postal code, phone number and website) from an excel file with company names using ggmap package.

This repository contains:
* get_info.R: R code with get_info function
* example.xlsx: example input file with 4 company names
* data_trans.xlsx: output file after applying get_info function to example.xlsx. Notice that the function successfully dealt with NULL phone_number and website, hence data_trans.xlsx contains NAs

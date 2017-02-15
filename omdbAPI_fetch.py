#!/usr/bin/env python

# Import libraries
import json, requests, re, csv, string
from collections import OrderedDict
# from unicodedata import normalize
# from collections import OrderedDict

# Declare input_file to be used to import movie names and year
input_file = '/Users/birupakhya/Google Drive/Courses/ADBMS/Movie_Database/movies_master.csv'

# Declare output_file to be used to store retreived information from OMDB_API in a CSV file
output_file = '/Users/birupakhya/Google Drive/Courses/ADBMS/Movie_Database/omdb_output.csv'

# Define a function that retreives response using requests library and then converts it into a json object. Failure gives an Error
def return_json(url):
    try:
        response = requests.get(url)
        if not response.status_code // 100 == 2:
            return "Error: Unexpected response {}".format(response)
        json_obj = response.json()
        return json_obj
    except requests.exceptions.RequestException as e:
        return "Error: {}".format(e)

failed_movies = []
movie_not_found = []

with open(input_file,'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    m_list = list(csv_reader)
    for i in range(1,len(m_list)):
        m_name = re.search(r'[^(0-9)]+',m_list[i][1],re.M)
        m_year = re.search(r'[0-9]+',m_list[i][1],re.M)
        if m_name:
            movie_name = m_name.group()
        if m_year:
            movie_year = m_year.group()

        request_head        = 'http://www.omdbapi.com/?'
        request_title       = 't='
        request_movie_name  = string.replace(movie_name,' ','+')
        request_movie_name  = request_movie_name.split(',',1)[0]
        request_year        = '&y='
        request_movie_year  = movie_year
        request_tail        = 'plot=full&r=json'
        request_url         = request_head + request_title + request_movie_name + request_year + request_movie_year + request_tail
        response            = return_json(request_url)
        
        try:
            oResponse = OrderedDict(response)
            if response['Response'] == 'True':
            # print oResponse
                with open(output_file, 'a') as f:
                    myWriter = csv.DictWriter(f,oResponse.keys())
                    myWriter.writerow(oResponse)
            else:
                movie_not_found.append(movie_name)
                print "Movie not found", movie_not_found
        except ValueError, Argument:
                    # print "Error: ", Argument
                    failed_movies.append(movie_name)
                    print "Failed movies", failed_movies


               
            

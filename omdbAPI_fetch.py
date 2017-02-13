import json, requests, re, csv, string
from unicodedata import normalize
from collections import OrderedDict

input_file 		= '/Users/birupakhya/Documents/Projects/Code/python/movies.csv'
output_file 	= '/Users/birupakhya/Documents/Projects/Code/python/omdb_movies_output1.csv'

def return_json(url):
    try:
        response = requests.get(url)
        if not response.status_code // 100 == 2:
            return "Error: Unexpected response {}".format(response)

        json_obj = response.json()
        return json_obj
    except requests.exceptions.RequestException as e:
        return "Error: {}".format(e)

with open(input_file,'r') as csv_file:
	csv_reader = csv.reader(csv_file)
	m_list = list(csv_reader)

	for i in range(1,len(m_list)):
		m_name 	= re.search(r'[^(0-9)]+',m_list[i][1],re.M)
		m_year 	= re.search(r'[0-9]+',m_list[i][1],re.M)
		movie_name = m_name.group()
		if m_name:
			movie_name = m_name.group()
		if m_year:
			movie_year = m_year.group()

request_head 		= 'http://www.omdbapi.com/?'
request_title		= 't='
request_movie_name 	= string.replace(movie_name,' ','+')
request_year		= '&y='
request_movie_year	= movie_year
request_tail		= 'plot=full&r=json'
request_url			= request_head + request_title + request_movie_name + request_year + request_movie_year + request_tail
response 			= return_json(request_url)

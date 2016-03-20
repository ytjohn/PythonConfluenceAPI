from PythonConfluenceAPI import ConfluenceAPI
from requests import HTTPError

USERNAME = 'admin'
PASSWORD = 'admin'
WIKI_SITE = 'http://localhost:1990/confluence'
API = ConfluenceAPI(USERNAME, PASSWORD, WIKI_SITE)

def test():
    pass

def test_get_spaces():

    spaces = API.get_spaces()
    if 'results' in spaces:
        assert True

def test_create_new_space():

    result = API.create_new_space({
        'key': 'TEST1',
        'name': 'My testing space',
        'description': {
            'plain': {'value': 'This is my new testing space', 'representation': 'plain'}
        }
    })

    if result['name'] == 'My testing space':
        assert True

def test_create_page():

    title = 'My landing page for TESTSPACE!'

    result = API.create_new_content({
        'type': 'page',
        'title': title,
        'space': {'key': 'TEST1'},
        'body': {
            'storage': {'value': '<h1>Welcome to the landing page!</h1><p>Lorem Ipsum</p>',
                        'representation': 'storage'
                        }
        }
    })

    if result['title'] == title:
        assert True

def test_get_content():

    key = 'TEST1'
    title = 'My landing page for TESTSPACE!'
    result = API.get_content(space_key=key, title=title)
    for result in result['results']:
        if result['title'] == title:
            assert True

def test_delete_page():

    key = 'TEST1'
    title = 'My landing page for TESTSPACE!'
    result = API.get_content(space_key=key, title=title)
    for result in result['results']:
        if result['title'] == title:
            id = result['id']

    try:
        d = API.delete_content_by_id(content_id=id)
        assert True
    except HTTPError:
        assert False

def test_delete_space():
    """Test space deletion"""

    try:
        result = API.delete_space(space_key='TEST1')
    except HTTPError:
        assert False

    if 'id' in result.keys():
        assert True
    else:
        assert False





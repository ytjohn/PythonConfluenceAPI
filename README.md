[![PyPI version](https://badge.fury.io/py/PythonConfluenceAPI.svg)](http://badge.fury.io/py/PythonConfluenceAPI)

![Alt Text](https://raw.githubusercontent.com/pushrodtechnology/PythonConfluenceAPI/master/pythonconfluenceapilight.png "PythonConfluenceAPI")

# PythonConfluenceAPI
PythonConfluenceAPI is a Pythonic API wrapper over the Confluence REST API, which cleanly wraps *all* of the
methods present in the current Confluence API spec, and is easily adapter to be used with minimal effort in other
frameworks such as concurrent futures, greenlets, and other concurrency schemes.

Read the latest PythonConfluenceAPI docs [here.](http://htmlpreview.github.io/?https://github.com/pushrodtechnology/PythonConfluenceAPI/blob/master/doc/html/index.html) 

# How To Use

    # Load API wrapper from library
    from PythonConfluenceAPI import ConfluenceAPI

    # Create API object.
    api = ConfluenceAPI('username', 'password', 'https://my.atlassian.site.com/wiki')

    # Get latest visible content from confluence instance.
    confluence_recent_data = api.get_content()

    # Create a new confluence space
    api.create_new_space({'key': 'TEST', 'name': 'My Test Space', 'description': 'This is a test confluence space'})

All of the API methods have docstrings attached which mirror the official Atlassian documentation, as the API
currently is a rather thin wrapper over top of the Confluence API. Users are advised to consult the source code or
look at the Atlassian API documentation for further info. Examples are also provided in the Examples directory of
the repository.

# Testing

This project uses tox for testing. These tests have an assumption of a confluence instance living
on localhost port 1990. For conveinence, a Vagrantfile has been provided that provides just that.

To learn about using HashiCorp Vagrant, see the [getting started](https://www.vagrantup.com/docs/getting-started/) guide.

You will also need to install tox (`pip install tox`) in order to run the test. Tox will handle creating
test virtualenvs for Python-2.7 and Python-3.4, 

To spin up the vagrant instance and perform tox tests:

    make test-with-vagrant
    
_(If you do not have the make command, read the Makefile for commands. Running `vagrant up; tox` will 
perform the same steps)._

This first run will have to download the atlassian/connect vagrant box, boot it, install and configure
Confluence. This could take around 10 minutes based on your system and Internet connection. Subsequent
test runs will complete in seconds.

If you have already stood up a confluence instance, or you already have vagrant running, simply run tox:

    tox
    
If you want to specifically test a specific version of python (say just py27), you can use tox to 
specify that environment:

    tox -e py27   # run tests under Python 2.7
    tox -e py34   # run tests under Python 3.4

If you want to test against an alternate Confluence instance, modify tests/test_api.py to
point to that instance. 

If you want to shut down the vagrant instance (but leave it in place for later):

    make vagrant-halt
    
To restart that instance, `make test-with-vagrant` will perform the steps.  After a reboot, 
it will takes 2-3 minutes to recreate an Atlassian instance. You can also run:

    vagrant up
    vagrant provision
    
To delete the vagrant instance completely:

    vagrant destroy
    



# License
This repository was written for Pushrod Technology by Robert Cope, and is licensed as LGPLv3.

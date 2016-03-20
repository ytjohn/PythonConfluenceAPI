.PHONY: clean-pyc test tox-test test-with-vagrant docs vagrant-up vagrant-destroy vagrant-provision test-with-vagrant

all: clean-pyc test

test:
	py.test tests

tox-test:
	tox

vagrant-up:
	vagrant up

vagrant-destroy:
	vagrant destroy

vagrant-provision:
	vagrant provision

test-with-vagrant: vagrant-up vagrant-provision tox-test

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

docs:
	$tox -e docs

SERVER=api-server 
CLIENT=api-client
TEST=${SERVER}\tests
BLUE='\033[0;34m'

all: run

sort: 
	@echo "\n${BLUE} Running isort..."
	@isort ${SERVER}

lint: 
	@echo "\n${BLUE} Running the flake8 linter..."
	@cd ${SERVER} && flake8
	@echo "\n${BLUE} Running the pylint linter..."
	@cd ${SERVER} && pylint --rcfile=setup.cfg api/

test: 
	@echo "\n${BLUE} Running the tests..."
	@SECRET_KEY=secret_key FLASK_ENV=development python -m  pytest 

update-pip:
	@pip install --upgrade pip

install: update-pip requirements.txt
	@pip install -r requirements.txt

install-dev: requirements-dev.txt
	@pip install -r requirements-dev.txt

build:
	@cd ${CLIENT} && npm run build
	@cp -r ${CLIENT}/build/* api-server/api/static/

run: build
	@cd ${SERVER} && echo SECRET_KEY=secret_key"\n"FLASK_ENV=development"\n"APP=app.py"\n" > .env 
	@cd ${SERVER} && flask run

release:
	@echo "\n${BLUE} Bumping the current version..."
	@cd ${SERVER} && cz bump
	@echo "\n${BLUE} Updating the change log..."
	@cd ${SERVER} && cz changelog

clean:
	@cd ${CLIENT} && rm -rf build 
	@rm -rf .pytest_cache
	@cd ${SERVER} && rm -rf .pytest_cache .coverage coverage.xml __pycache__ ${PACKAGE}/__pycache__ ${TEST}/__pycache__ api/__pycache__ api/static 
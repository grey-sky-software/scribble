#!make
include docker/.env.development
export $(cat docker/.env.development | xargs)

.PHONY: bundle-install
bundle-install:
	@docker compose run --rm --no-deps --name scribble_install web bundle install

# Removes named volumes declared in the volumes section of the Compose file and anonymous volumes attached to containers
# Also removes the image tagged "scribble"
.PHONY: clean
clean:
	@docker compose down -v --rmi all

# Removes all volumes and images, both those related to "scribble" and dangling
.PHONY: clean-hard
clean-hard:
	@docker compose down -v && docker system prune -a -f

.PHONY: init
init:
	@docker compose build && docker compose run --rm --name scribble web docker/init

.PHONY: lint
lint:
	@docker compose run --rm --no-deps --name scribble_linter web bundle exec rake lint $(filter-out $@,$(MAKECMDGOALS))

.PHONY: lint-ci
lint-ci:
	@docker compose run --rm --no-deps --name scribble_linter web bundle exec rubocop --require rubocop-airbnb $(filter-out $@,$(MAKECMDGOALS))
	@docker compose run --rm --no-deps --name scribble_linter web bundle exec reek $(filter-out $@,$(MAKECMDGOALS))

.PHONY: logs
logs:
	@docker compose logs

.PHONY: logstail
logstail:
	@docker compose logs -f

.PHONY: shell
shell:
	@docker compose exec web sh

.PHONY: start
start:
	@docker compose up --build -d postgres web

.PHONY: status
status:
	@echo "Running services:"
	@docker ps --filter name=scribble --format "table {{.Names}}\t{{.RunningFor}}\t{{.Status}}"

.PHONY: stop
stop:
	@docker compose stop

.PHONY: test
test:
	@docker compose run --rm --name scribble_tests web docker/test $(filter-out $@,$(MAKECMDGOALS))

# Catch-all target which does nothing
%:
	@:


.PHONY: bundle-install
bundle-install:
	@docker compose run --rm --no-deps --name scribble_install web bundle install

.PHONY: clean
clean:
	@docker compose down -v

.PHONY: init
init:
	@docker compose build && docker compose run --rm --name scribble web docker/init

.PHONY: lint
lint:
	@docker compose run --rm --no-deps --name scribble_linter web bundle exec rake lint $(filter-out $@,$(MAKECMDGOALS))

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

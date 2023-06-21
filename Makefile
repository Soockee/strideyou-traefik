
run:
	docker-compose up

# TODO get this from OS env?
ENVIRONMENT:=prod
DEV_ENV_FILE:=.env.dev
PROD_ENV_FILE:=.env.prod

deploy:
	@echo " - deploying to $(ENVIRONMENT)"
ifeq ($(ENVIRONMENT), dev)
	$(call setup_env,dev)
	docker compose  --env-file $(DEV_ENV_FILE) up -d --remove-orphans
else ifeq ($(ENVIRONMENT), prod)
	$(call setup_env,prod)
	docker compose  --env-file $(PROD_ENV_FILE) up -d --remove-orphans
else
	@echo "Invalid environment. Please specify ENVIRONMENT=dev or ENVIRONMENT=prod"
	@exit 1
endif

teardown:
	@echo " - teardown $(ENVIRONMENT) env"
ifeq ($(ENVIRONMENT), dev)
	$(call setup_env,dev)
	docker compose --env-file $(DEV_ENV_FILE) down
else ifeq ($(ENVIRONMENT), prod)
	$(call setup_env,prod)
	docker compose --env-file $(PROD_ENV_FILE) down
else
	@echo "Invalid environment. Please specify ENVIRONMENT=dev or ENVIRONMENT=prod"
	@exit 1
endif


clean:
	@echo " - cleaning $(ENVIRONMENT) env"
ifeq ($(ENVIRONMENT), dev)
	$(call setup_env,dev)
	docker compose --env-file $(DEV_ENV_FILE) down
	
	@read -p "Are you sure you want to delete $(BACKEND_STORAGE_PATH)? [y/N] " answer; \
	if [[ $$answer == [Yy] ]]; then \
		sudo rm -rf $(BACKEND_STORAGE_PATH); \
	fi
else ifeq ($(ENVIRONMENT), prod)
	$(call setup_env,prod)
	docker compose --env-file $(PROD_ENV_FILE) down
endif
	

## printing env vars
## format: 
## make print-<Variable Name>
print-%:
	@echo $* = $($*)
print-env: 
	$(call setup_env, dev)
	$(call setup_env, prod)
	

define setup_env
	$(eval ENV_FILE := .env.$(1))
	@echo " - setup env $(ENV_FILE)"
	@echo " -- env content start --"
	@cat $(ENV_FILE)
	@echo " -- env content ende --"
	$(eval include .env.$(1))
	$(eval export sed 's/=.*//'.env.$(1))
endef



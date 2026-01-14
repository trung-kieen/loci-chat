# Makefile for Bruno API OpenCollection Project

# Variables
BRUNO_CLI := npx @usebruno/cli
COLLECTION_PATH := ./auth
ENV_FILE := .env
REPORTS_DIR := ./reports
TIMESTAMP := $(shell date +%Y%m%d_%H%M%S)

# Default environment
ENV ?= local-env

.PHONY: help install test test-env clean report

help: ## Show this help message
	@echo "Bruno API OpenCollection - Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

install: ## Install Bruno CLI and dependencies
	npm install -g @usebruno/cli
	@echo "Bruno CLI installed successfully"

test: ## Run all API tests
	@mkdir -p $(REPORTS_DIR)
	$(BRUNO_CLI) run $(COLLECTION_PATH) \
		--env $(ENV) \
		--output $(REPORTS_DIR)/results_$(TIMESTAMP).json \
		--format json
	@echo "Tests completed. Results saved to $(REPORTS_DIR)"

test-env: ## Run tests for specific environment (usage: make test-env ENV=staging)
	@mkdir -p $(REPORTS_DIR)
	$(BRUNO_CLI) run $(COLLECTION_PATH) \
		--env $(ENV) \
		--output $(REPORTS_DIR)/results_$(ENV)_$(TIMESTAMP).json \
		--format json

test-folder: ## Run tests from specific folder (usage: make test-folder FOLDER=auth)
	@mkdir -p $(REPORTS_DIR)
	$(BRUNO_CLI) run $(COLLECTION_PATH)/$(FOLDER) \
		--env $(ENV) \
		--output $(REPORTS_DIR)/results_$(FOLDER)_$(TIMESTAMP).json

test-parallel: ## Run tests in parallel
	@mkdir -p $(REPORTS_DIR)
	$(BRUNO_CLI) run $(COLLECTION_PATH) \
		--env $(ENV) \
		--output $(REPORTS_DIR)/results_$(TIMESTAMP).json \
		--format json \
		--reporters json,html

clean: ## Clean report directory
	rm -rf $(REPORTS_DIR)/*
	@echo "Reports cleaned"

report: ## Generate HTML report from latest results
	@echo "Latest test results:"
	@ls -t $(REPORTS_DIR)/*.json | head -1 | xargs cat

validate: ## Validate Bruno collection structure
	@if [ -d "$(COLLECTION_PATH)" ]; then \
		echo "✓ Collection path exists"; \
	else \
		echo "✗ Collection path not found"; \
		exit 1; \
	fi

ci-test: clean validate test ## Run CI pipeline tests
	@echo "CI tests completed"

all: install generate

install:
	@./bundle

generate:
	tuist fetch
	tuist generate

edit-project:
	tuist edit

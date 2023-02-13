all: generate

generate:
	tuist fetch
	tuist generate

edit:
	tuist edit

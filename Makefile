# Variables
INSTALL_DIR = $(HOME)/.local/bin
SCRIPT = vim
LINK = vi

.PHONY: install clean build push

all:

install:
	@mkdir -p $(INSTALL_DIR)
	@cp $(SCRIPT) $(INSTALL_DIR)/$(SCRIPT)
	@chmod +x $(INSTALL_DIR)/$(SCRIPT)
	@ln -sf $(INSTALL_DIR)/$(SCRIPT) $(INSTALL_DIR)/$(LINK)
	@if ! echo $$PATH | grep -q $(INSTALL_DIR); then \
		echo 'export PATH="$(INSTALL_DIR):$$PATH"' >> $(HOME)/.bashrc; \
		echo 'Added $(INSTALL_DIR) to PATH in .bashrc'; \
	fi
	echo "Please re-login to apply the changes"; \

clean:
	# Remove the vim script and vi symbolic link
	@rm -f $(INSTALL_DIR)/$(SCRIPT)
	@rm -f $(INSTALL_DIR)/$(LINK)
	echo "Please re-login to apply the changes"; \

# Dockerfile 
build:
	docker build --rm -t myoungone/vim:0.1 --file Dockerfile .

push:
	docker push myoungone/vim:0.1

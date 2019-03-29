open-app:
	if [ -d app-darwin-x64/app.app ]; then open app-darwin-x64/app.app/; fi

meteor:
	which meteor || curl https://install.meteor.com/ | sh

kitchen: meteor
	which meteor-kitchen || curl https://www.meteorkitchen.com/install | sh

install-all: meteor kitchen

remove-meteor:
	sudo rm -rf /usr/local/bin/meteor
	rm -rf ~/.meteor

remove-kitchen:
	rm -rf ~/.meteor-kitchen

cleanup:
	rm -rf node_modules/
	rm -f package-lock.json

remove-app:
	if [ -d app-darwin-x64/app.app ]; then rm -rf app-darwin-x64/; fi	

remove-all: remove-kitchen remove-meteor cleanup remove-app

nativefier: meteor
	if [ ! -d node_modules ]; then meteor npm i nativefier; fi

create-app: nativefier
	node_modules/.bin/nativefier --width 400 --height 600 --name "app" "http://localhost:3000"

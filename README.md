This project is an API for [**Brittle Pins**](https://brittle-pins.com) app bootstrapped with [rails new ... --api](https://guides.rubyonrails.org/api_app.html).

## Prerequisites
- Ruby 2.7.0
- Rails 6.0.2.1
- PostgreSQL (can be installed with Homebrew: `brew install postgresql`; **remember to start the service!**)
- Redis (can be installed with Homebrew: `brew install redis`)

## How to run

To run the app, first download the code of the [client](https://github.com/ekaterina-nikonova/brittle-pins-web)
in the folder called `brittle-pins-web` and make it a sibling of the API's folder.
The command `rails start` will make the app run on port `3000`.

Keep in mind that port numbers are hard-coded: the API runs on port `3001`.
If you change any of the ports, the client will fail to communicate with the API.
The run configuration is stored in the file `/Procfile.dev`, while the CORS
permissions configurations are stored in the `/config/environments` folder.

## If fails to run

Sometimes, the server fails to run, while the client succeeds.
This results in the inability to restart the app, since the client's port is taken.
You will see this as `Something is already running on port 3000` error.

To kill the client, first find the ID of the process:
```
$ lsof -i :3000
```

In the list of results, find the `node` command and its PID, then use:
```
$ kill -9 <PID>
```

Try to refresh the page in the browser to make sure that it fails to connect to the server.

## Missing master key

The Rails master key is not included in the repository and should be added in `/config/master.key` manually.
The key is only available to the app owner, since the app is not meant to be run by any third party.

## How to test

Run all tests with `rspec`. Thanks to the [simplecov gem](https://github.com/colszowka/simplecov),
they run with coverage. The result is stored in the `/coverage` folder.
To see the report, open the `/coverage/index.html` file.

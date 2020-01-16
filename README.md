This project is an API for [**Brittle Pins**](https://brittle-pins.com) app bootstrapped with [rails new ... --api](https://guides.rubyonrails.org/api_app.html).

## How to run

To run the app, first download the code of the [client](https://github.com/ekaterina-nikonova/brittle-pins-web)
in the folder called `brittle-pins-web` and make it a sibling of the API's folder.
The command `rails start` will make the app run on port `3000`.

Keep in mind that port numbers are hard-coded: the API runs on port `3001`.
If you change any of the ports, the client will fail to communicate with the API.
The run configuration is stored in the file `/Procfile.dev`, while the CORS
permissions configurations are stored in the `/config/environments` folder.

## How to test

Run all tests with `rspec`. Thanks to the [simplecov gem](https://github.com/colszowka/simplecov),
they run with coverage. The result is stored in the `/coverage` folder.
To see the report, open the `/coverage/index.html` file.

const express = require('express');
const cors = require('cors');
const connectDB = require('./db/connections');

const routes = require('./routes');

if (process.env.NODE_ENV !== 'test') {
	connectDB();
}

const app = express();

app.use(express.json());

const corsOptions = {
	origin: 'https://snake.adamsackfield.uk',
	optionsSuccessStatus: 200,
};

app.use(cors(corsOptions));

app.use('/api', routes);

app.get('/', (req, res) => {
	res.status(200).send({ message: 'Running' });
});

app.use((err, req, res, next) => {
	if (err.status && err.message) {
		res.status(err.status).send({ message: err.message });
	} else {
		next(err);
	}
});

app.all('*', (req, res) => {
	res.status(404).send({ message: 'Path not found' });
});

module.exports = app;
